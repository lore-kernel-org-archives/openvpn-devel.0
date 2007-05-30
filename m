Message-ID: <6c18a4f0705301137q3c63230en25dbd69f9b2f4061@...278...>
Date: Wed, 30 May 2007 20:37:00 +0200
From: "Bernd Bartmann" <bernd.bartmann@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Possible bug in OpenVPN-2.0.9
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Openvpn-devel@lists.sourceforge.net

Hi,

I'm running Centos 5 32bit and installed openvpn-2.0.9-1.el5.rf from
Dag Wieers Repo. When OpenVPN is started during boot-up it just shows
an SElinux related error message and does not start. When I start
OpenVPN manually after
the system has come up completely it works fine. Please have a look at
the log extract at the end of this email for all SElinux related
messages.

I already reported this problem to the Centos and SElinux mailing
lists. Daniel Walsh (SElinux guru) had the following suggestions:

> Easiest thing to do is update policy with these two rules.
>
> # grep openvpn /var/log/audit/audit.log | audit2allow -M myopenvpn
> # semodule -i myopenvpn.pp
>
> This will add the following rules:
> allow openvpn_t pppd_t:fd use;
> allow openvpn_t self:process execstack;
>
> The pppd_t:fd is probably a leaked file descriptor and could probably be
> dontaudited.
> The execstack is potentially a problem in openvpn_t.  This is probably a
> coding problem and should be reported as a bug/
>
> SELinux Memory Protection Tests
> <http://people.redhat.com/%7Edrepper/selinux-mem.html>

So he suggests that the execstack errors come from a bug in OpenVPN.

Here are all the messages from /var/log/messages that are SElinux related:

 May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:10): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:11): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.395:12): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.458:13): avc:
denied  { execstack } for  pid=3012 comm="openvpn"
scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:openvpn_t:s0 tclass=process
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:14): avc:
denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:15): avc:
denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.465:16): avc:
denied  { use } for  pid=3014 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:39:15 srsblnfw01 kernel: audit(1180381151.466:17): avc:
denied  { execstack } for  pid=3014 comm="openvpn"
scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:openvpn_t:s0 tclass=process
May 28 21:40:06 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 21:40:06 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:10): avc:
denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:11): avc:
denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.319:12): avc:
denied  { use } for  pid=3010 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.382:13): avc:
denied  { execstack } for  pid=3010 comm="openvpn"
scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:openvpn_t:s0 tclass=process
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:14): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:15): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:16): avc:
denied  { use } for  pid=3012 comm="openvpn" name="null" dev=tmpfs
ino=1396 scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:pppd_t:s0 tclass=fd
May 28 21:44:26 srsblnfw01 kernel: audit(1180381461.390:17): avc:
denied  { execstack } for  pid=3012 comm="openvpn"
scontext=system_u:system_r:openvpn_t:s0
tcontext=system_u:system_r:openvpn_t:s0 tclass=process
May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:18:52 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:26:00 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "use" access to /dev/null (pppd_t).
For complete SELinux messages. run sealert -l
5701a4da-1d96-4c86-9747-e31b3d5d2219
May 28 22:42:03 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:42:05 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:42:05 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:56:42 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0
May 28 22:56:42 srsblnfw01 setroubleshoot:      SELinux is preventing
/usr/sbin/openvpn (openvpn_t) "execstack" access to <Unknown>
(openvpn_t).      For complete SELinux messages. run sealert -l
0b738097-f92a-44c4-952b-7247d88a40e0

Best regards,
Bernd

