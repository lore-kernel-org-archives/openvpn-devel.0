Message-ID: <41B0734E.3010105@...324...>
From: Stefan Engel <mail@...324...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050401070106040906070809"
Subject: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Dec  3 06:09:07 2004
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050401070106040906070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
section the init script is always taken from /etc/rc.d/init.d instead
of /etc/init.d in case of a SuSE distribution. This results in an
rpm build error on SuSE systems.

The appended patch should fix this.

Regards,

Stefan

--------------050401070106040906070809
Content-Type: text/plain;
 name="openvpn.spec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn.spec.diff"

--- openvpn.spec.19	2004-12-03 10:56:30.000000000 +0100
+++ openvpn.spec	2004-12-03 10:57:28.000000000 +0100
@@ -91,7 +91,11 @@
 %{_sbindir}/%{name}
 %{_datadir}/%{name}
 %dir /etc/%{name}
+%if "%{VENDOR}" == "SuSE"
+/etc/init.d/%{name}
+%else
 /etc/rc.d/init.d/%{name}
+%endif
 
 %changelog
 

--------------050401070106040906070809--

