Date: Tue, 28 Nov 2006 12:39:55 +0300
From: spam <spam@...954...>
Message-ID: <1475992654.20061128123955@...954...>
In-Reply-To: <mailman.0.1164705945.14600.openvpn-devel@lists.sourceforge.net>
References: <mailman.0.1164705945.14600.openvpn-devel@lists.sourceforge.net>
MIME-Version: 1.0
Subject: [Openvpn-devel] bug in easy-rsa in windows
Reply-To: spam <spam@...954...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

i use openvpn-2.1_rc1-install.exe
made ca and server sertefikate, but got error
Certificate does not have key usage extension
when trying to do
remote-cert-tls server
in client

solution:
in file easy-rsa/openssl.cnf section [ server ] i have to add 2 lines:
-
extendedKeyUsage=serverAuth
keyUsage = digitalSignature, keyEncipherment
-
then remake certefikates. and after it everything is fine.

unix version is fine.


