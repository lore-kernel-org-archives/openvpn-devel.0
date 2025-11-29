Message-ID: <2021d22e93620793b0fd0e331878121c.20251129190809.1764439689@...2556...>
Date: Sat, 29 Nov 2025 19:08:09 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20251129190809_34687"
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.7_rc3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: Yuriy Darnobyt <yuriy.darnobyt@...2722...>, openvpn-devel@lists.sourceforge.net

------=_20251129190809_34687
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

> Hi,
>
>> The OpenVPN community project team is proud to release OpenVPN 2.7_rc3.
>>
>> This is the third release candidate for the feature release 2.7.0.
>>
>
> Can one of the developers please add this little patch?
>
> https://github.com/OpenVPN/openvpn/issues/834
>
> It would be much appreciated.

The patch is attached to this email. Would be nice if it was considered.

Regards,
Simon
------=_20251129190809_34687
Content-Type: text/x-patch; name="openvpn-2.7_beta1-nice.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="openvpn-2.7_beta1-nice.patch"

diff -Naupr openvpn-2.7_beta1.orig/distro/systemd/openvpn-client@...2221... openvpn-2.7_beta1/distro/systemd/openvpn-client@...2221...
--- openvpn-2.7_beta1.orig/distro/systemd/openvpn-client@...2221...	2025-09-03 22:32:15.000000000 +0200
+++ openvpn-2.7_beta1/distro/systemd/openvpn-client@...2221...	2025-09-09 15:20:13.626261097 +0200
@@ -11,7 +11,7 @@ Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_SYS_NICE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff -Naupr openvpn-2.7_beta1.orig/distro/systemd/openvpn-server@...2221... openvpn-2.7_beta1/distro/systemd/openvpn-server@...2221...
--- openvpn-2.7_beta1.orig/distro/systemd/openvpn-server@...2221...	2025-09-03 22:32:15.000000000 +0200
+++ openvpn-2.7_beta1/distro/systemd/openvpn-server@...2221...	2025-09-09 15:20:30.842288757 +0200
@@ -11,7 +11,7 @@ Type=notify
 PrivateTmp=true
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT_WRITE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_SYS_NICE CAP_AUDIT_WRITE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
------=_20251129190809_34687--



