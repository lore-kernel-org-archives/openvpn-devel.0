From: P Kern <pak@...698...>
Message-Id: <06Jul11.104339edt.35585@...699...>
Date: Tue, 11 Jul 2006 10:43:39 -0400
Subject: [Openvpn-devel] Patch: allow browser as a management GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: pak@...698...


Hello.

Just fyi - a patch (id 1520128) has been posted to Sourceforge
which allows a browser to connect to the management interface.
The patch is based on openvpn-2.1_beta14.

Since most platforms now have a web browser, this patch could
lessen the need for a separate OpenVPN management GUI.

Hope this patch proves useful.

Paul Kern, CNS, U Toronto.

-------------------------------------------------------------

http://sourceforge.net/tracker/index.php?func=detail&aid=1520128&group_id=48978&atid=454721

Included in this patch:
  - code to extract commands from HTTP format messages.
  - code to send HTML-wrapped replies as HTTP messages.
  - a simple built-in default "home page".

Example usage:
  - configure a patched OpenVPN with ...
      management localhost 7505
      management-query-passwords
      management-hold
      management-http             <--[NEW]
  - point your web browser at "http://localhost:7505/"
     eg.
        % lynx http://localhost:7505/

Note: real-time messages are not available due to the
nature of HTTP.

Compiled+tested on:
   FreeBSD 4.10, FreeBSD 5.4, RedHat Linux 2.6.13

Browsers tested:
   Lynx, Mozilla, Opera, MSIE.


