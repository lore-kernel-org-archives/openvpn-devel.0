Message-ID: <41BDD765.4010107@...324...>
From: Stefan Engel <mail@...324...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000605090307090301090801"
Subject: [Openvpn-devel] correction for init script for SuSE
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
Date: Mon Dec 13 09:55:02 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000605090307090301090801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

the init script for SuSE (source in suse/openvpn.init) contains a bug
regarding the location of the openvpn binary when used in an RPM.
If OpenVPN is built using rpm then the resulting binary is installed
as /usr/sbin/openvpn. The init script contains the following lines

 > # Location of openvpn binary
 > openvpn="/usr/local/sbin/openvpn"

/usr/local/sbin/openvpn may be valid when installing from tar.gz, but
not if using rpm.

Attached is a patch against openvpn.spec in 2.0rc3 which should fix
this.

Regards,

Stefan

--------------000605090307090301090801
Content-Type: text/plain;
 name="openvpn.spec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn.spec.diff"

--- openvpn.spec.orig	2004-12-13 18:39:14.000000000 +0100
+++ openvpn.spec	2004-12-13 18:49:48.000000000 +0100
@@ -117,7 +117,9 @@
 # Install init script
 %if "%{VENDOR}" == "SuSE"
 %__install -c -d -m 755 %{buildroot}/etc/init.d
-%__install -c -m 755 suse/%{name}.init %{buildroot}/etc/init.d/%{name}
+%__sed -e 's#openvpn=\"/usr/local/sbin/openvpn\"#openvpn=\"/usr/sbin/openvpn\"#' < suse/%{name}.init > %{_tmppath}/%{name}.init
+%__install -c -m 755 %{_tmppath}/%{name}.init %{buildroot}/etc/init.d/%{name}
+%__rm %{_tmppath}/%{name}.init 
 %else
 %__install -c -d -m 755 %{buildroot}/etc/rc.d/init.d
 %__install -c -m 755 sample-scripts/%{name}.init %{buildroot}/etc/rc.d/init.d/%{name}

--------------000605090307090301090801--

