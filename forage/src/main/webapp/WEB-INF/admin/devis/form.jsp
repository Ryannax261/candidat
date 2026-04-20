<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${devis.id == 0 ? "Nouveau Devis" : "Modifier Devis"}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <jsp:include page="../../layout/navbar.jsp" />
    <div class="container" style="max-width: 900px;">
        <div class="header-actions">
            <h1>Saisie du Devis</h1>
            <a href="${pageContext.request.contextPath}/admin/devis" class="btn btn-secondary">Retour</a>
        </div>
        
        <div class="card" style="padding: 1.5rem;">
            <form id="devisForm" action="${pageContext.request.contextPath}/admin/devis/save" method="post">
                <input type="hidden" name="id" value="${devis.id}">
                
                <div style="display: flex; gap: 1.5rem; margin-bottom: 0.5rem;">
                    <div class="form-group" style="flex: 1;">
                        <label for="demandeId">ID Demande</label>
                        <input type="number" id="demandeId" name="demandeId" class="form-control" required 
                               onblur="checkDemande(this.value)">
                        <div id="demandeError" class="error-message">ID Demande introuvable.</div>
                    </div>
                    
                    <div class="form-group" style="flex: 1;">
                        <label for="typeDevisId">Type de Devis</label>
                        <select id="typeDevisId" name="typeDevisId" class="form-control" required>
                            <option value="">Sélectionnez un type</option>
                            <c:forEach var="t" items="${types}">
                                <option value="${t.id}">${t.nom}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Ces informations sont remplies dynamiquement avec JavaScript (la fonction checkDemande plus bas) -->
                <div id="demandeInfo" class="info-card">
                    <h4>Informations de la demande</h4>
                    <p><strong>Client :</strong> <span id="infoClient"></span></p>
                    <p><strong>Date :</strong> <span id="infoDate"></span></p>
                    <p><strong>Lieu/District :</strong> <span id="infoDistrict"></span></p>
                </div>

                <h3>Détails du Devis</h3>
                <table id="detailsTable" class="details-table">
                    <thead>
                        <tr>
                            <th>Libellé</th>
                            <th>PU (Ar)</th>
                            <th>Quantité</th>
                            <th>Total (Ar)</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr class="total-row">
                            <td colspan="3" style="text-align: right;">Montant Total Global :</td>
                            <td id="grandTotal">0.00</td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
                <button type="button" class="btn btn-success btn-add" onclick="addRow()">
                    <i class="fas fa-plus"></i> Ajouter une ligne
                </button>
                
                <div class="form-group" style="margin-top: 30px; text-align: right;">
                    <button type="submit" class="btn btn-primary" id="btnSubmit" disabled>Enregistrer Devis</button>
                </div>
            </form>
        </div>
    </div>

    <script>

        var contextPath = '${pageContext.request.contextPath}';

        function checkDemande(id) {
            const errorDiv = document.getElementById('demandeError');
            const infoDiv = document.getElementById('demandeInfo');
            const submitBtn = document.getElementById('btnSubmit');

            if (!id) {
                errorDiv.style.display = 'none';
                infoDiv.style.display = 'none';
                return;
            }

            // contextPath est résolu par JSP, ${id} ici est une variable JS (pas JSP EL)
            fetch(contextPath + '/admin/devis/api/demande/' + id)
                .then(response => {
                    if (!response.ok) throw new Error('Not found');
                    return response.json();
                })
                .then(data => {
                    errorDiv.style.display = 'none';
                    document.getElementById('infoClient').innerText = data.clientNom;
                    document.getElementById('infoDate').innerText = data.dateDemande;
                    document.getElementById('infoDistrict').innerText = data.district;
                    infoDiv.style.display = 'block';
                    submitBtn.disabled = false;
                })
                .catch(err => {
                    errorDiv.style.display = 'block';
                    infoDiv.style.display = 'none';
                    submitBtn.disabled = true;
                });
        }

        function addRow() {
            const tbody = document.querySelector('#detailsTable tbody');
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td><input type="text" name="libelle[]" class="form-control" required></td>
                <td><input type="number" step="0.01" name="pu[]" class="form-control text-right" required oninput="calculateRowTotal(this)"></td>
                <td><input type="number" name="qtt[]" class="form-control text-right" required oninput="calculateRowTotal(this)"></td>
                <td class="row-total text-right">0.00</td>
                <td class="text-center"><i class="fas fa-times btn-remove" onclick="removeRow(this)"></i></td>
            `;
            tbody.appendChild(tr);
        }

        function removeRow(element) {
            element.closest('tr').remove();
            calculateGrandTotal();
        }

        function calculateRowTotal(input) {
            const tr = input.closest('tr');
            const pu = parseFloat(tr.querySelector('input[name="pu[]"]').value) || 0;
            const qtt = parseFloat(tr.querySelector('input[name="qtt[]"]').value) || 0;
            
            let total = pu * qtt;
            
            
            if (pu >= 1000000) {
                pu = pu * 0.9;
                tr.querySelector('.row-total').style.color = '#e74c3c'; 
                tr.querySelector('.row-total').title = 'Remise de 10% incluse';
            } else {
                tr.querySelector('.row-total').style.color = 'inherit';
                tr.querySelector('.row-total').title = '';
            }

            tr.querySelector('.row-total').innerText = total.toLocaleString('fr-MG', { minimumFractionDigits: 2 });
            calculateGrandTotal();
        }

        function calculateGrandTotal() {
            let total = 0;
            document.querySelectorAll('.row-total').forEach(cell => {
                const val = parseFloat(cell.innerText.replace(/\s/g, '').replace(',', '.')) || 0;
                total += val;
            });
            document.getElementById('grandTotal').innerText = total.toLocaleString('fr-FR', { minimumFractionDigits: 2 });
        }
        addRow();
    </script>
</body>
</html>
