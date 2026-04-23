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
    <div class="container">
        <div class="header-actions">
            <h1>Nouveau Devis</h1>
            <a href="${pageContext.request.contextPath}/admin/devis" class="btn btn-secondary">Retour</a>
        </div>
        
        <div class="card">
            <form id="devisForm" action="${pageContext.request.contextPath}/admin/devis/save" method="post">
                <input type="hidden" name="id" value="${devis.id}">
                
                <div class="form-group">
                    <label for="demandeId">ID de la Demande</label>
                    <input type="number" id="demandeId" name="demandeId" required 
                           onblur="checkDemande(this.value)">
                    <div id="demandeError" style="color:red; display:none;">ID introuvable</div>
                </div>
                
                <div class="form-group">
                    <label for="typeDevisId">Type de Devis</label>
                    <select id="typeDevisId" name="typeDevisId" required>
                        <option value="">-- Choisir --</option>
                        <c:forEach var="t" items="${types}">
                            <option value="${t.id}">${t.nom}</option>
                        </c:forEach>
                    </select>
                </div>

                <div id="demandeInfo" style="display:none; padding:10px; border:1px solid #ccc; margin-bottom:10px;">
                    <p>Client: <span id="infoClient"></span></p>
                    <p>Lieu: <span id="infoDistrict"></span></p>
                </div>

                <table id="detailsTable">
                    <thead>
                        <tr>
                            <th>Libellé</th>
                            <th>P.U</th>
                            <th>Qtt</th>
                            <th>Total</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody></tbody>
                </table>

                <div style="margin: 20px 0; font-weight: bold;">
                    Total: <span id="grandTotal">0.00</span> Ar
                </div>

                <div class="form-group">
                    <button type="button" class="btn btn-secondary" onclick="addRow()">+ Ajouter ligne</button>
                    <button type="submit" class="btn btn-primary" id="btnSubmit" disabled>Enregistrer</button>
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
                <td><input type="text" name="libelle[]" required placeholder="Ex: Tuyaux PVC 110mm"></td>
                <td><input type="number" step="0.01" name="pu[]" required style="text-align: right;" oninput="calculateRowTotal(this)" placeholder="0.00"></td>
                <td><input type="number" name="qtt[]" required style="text-align: right;" oninput="calculateRowTotal(this)" placeholder="0"></td>
                <td class="row-total" style="text-align: right; font-weight: 500;">0.00</td>
                <td style="text-align: center;"><i class="fas fa-trash-alt" style="color: var(--danger); cursor: pointer; opacity: 0.6;" onclick="removeRow(this)"></i></td>
            `;
            tbody.appendChild(tr);
        }

        function removeRow(element) {
            element.closest('tr').remove();
            calculateGrandTotal();
        }

        function calculateRowTotal(input) {
            const tr = input.closest('tr');
            let pu = parseFloat(tr.querySelector('input[name="pu[]"]').value) || 0;
            const qtt = parseFloat(tr.querySelector('input[name="qtt[]"]').value) || 0;
            
            // Logique de remise 10%
            if (pu >= 1000000) {
                pu = pu * 0.9;
                tr.querySelector('.row-total').style.color = 'var(--accent)';
                tr.querySelector('.row-total').title = 'Remise de 10% appliquée';
            } else {
                tr.querySelector('.row-total').style.color = 'inherit';
                tr.querySelector('.row-total').title = '';
            }

            let total = pu * qtt;
            tr.querySelector('.row-total').innerText = total.toLocaleString('fr-FR', { minimumFractionDigits: 2 });
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
