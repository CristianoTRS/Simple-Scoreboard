$(function() {

    $('#main').hide();

    window.addEventListener('message', function(event) {

        const item = event.data;
        const action = item.action;

        if (action == 'show') {

            const players = item.players;
            const config = item.config;
    
            function generateHead() {
                var headString = '<tr>';
                if (config.ShowNames) headString += '<th scope="col">Name</th>';
                if (config.ShowPing) headString += '<th scope="col">Ping</th>';
                if (config.ShowId) headString += '<th scope="col">Id</th>';
                if (config.ShowJobs) headString += '<th scope="col">Job</th>';
                headString += '</tr>';
                return headString;
            }
    
            function generateRow(i) {
                var rowString = `<tr id="${players[i].id}">`;
                if (config.ShowNames) rowString += `<td><b>${players[i].playerName}</b></td>`;
                if (config.ShowPing) rowString += `<td>${players[i].playerPing}</td>`;
                if (config.ShowId) rowString += `<td>${players[i].playerId}</td>`;
                if (config.ShowJobs) rowString += `<td>${players[i].playerJob}</td>`;
                rowString += '</tr>';
                return rowString;
            }

            $('#main').show("slow");
            if (!players) return;

            $('#table').remove();
            $('#main').append('<table id="table" class="table table-dark table-responsive"></table>')
            $('#table').append(generateHead());
            $('#table').append('<tbody id="body"></tbody>');

            for (var i = 0; i < players.length; i++) {
                $('#body').append(generateRow(i));
            }

        } else if (action == 'hide') {
            $('#main').hide("slow");
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27 || data.which == 8) {
            $.post('http://ui/close', JSON.stringify({}));
        }
    };
})