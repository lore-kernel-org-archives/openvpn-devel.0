Message-ID: <4B8DD132.1050301@...1299...>
Date: Wed, 03 Mar 2010 16:02:10 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
Subject: [Openvpn-devel] bug in cryptoapi when run as a service?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi there

I'm trying openvpn-2.1.1 under XP and Win7 and am finding issue after
issue with Win7. Most are Win7's fault, but this one looks real.

I've got openvpn running as a service (running as SYSTEM), where I've
inserted the client cert via MMC (ie it's available to SYSTEM). After a
reboot, or after "stop->start" of the service, openvpn successfully
loads and connects - the VPN is up. However, if the network goes down
(say, because the laptop decided to go to sleep and was later woken up),
then openvpn exits instead of reconnecting (see below for logs). So I'm
guessing openvpn.exe exits - but it doesn't tell openvpnserv.exe that -
and it doesn't trigger a restart or anything - it's Game Over (the
openvpn service still states the service is running).

As it works after a reboot (ie before anyone logs in - so no
cert-in-user-profile issues), this "cannot load certificate" is plain
wrong. I'm guessing it's a bug with openvpn? Also, shouldn't openvpn.exe
"tell" openvpnserv.exe when it exits - so that openvpnserv.exe can
restart it? Isn't that the point of having it as a service? To
reiterate: if, after the below error occurs, I restart the service or
reboot, the tunnel comes up fine.

Thanks

Jason


-----------------------------------------------------------------------

Wed Mar 03 15:39:25 2010 [server.name] Inactivity timeout
(--ping-restart), restarting
Wed Mar 03 15:39:25 2010 TCP/UDP: Closing socket
...
Wed Mar 03 15:39:28 2010 Route deletion via IPAPI succeeded [adaptive]
Wed Mar 03 15:39:28 2010 Closing TUN/TAP interface
Wed Mar 03 15:39:28 2010 SIGUSR1[soft,ping-restart] received, process
restarting
Wed Mar 03 15:39:28 2010 Restart pause, 2 second(s)
Wed Mar 03 15:39:30 2010 NOTE: the current --script-security setting may
allow this configuration to call user-defined scripts
Wed Mar 03 15:39:30 2010 NOTE: --script-security method='system' is
deprecated due to the fact that passed parameters will be subject to
shell expansion
Wed Mar 03 15:39:30 2010 Cannot load certificate "SUBJ:client" from
Microsoft Certificate Store: error:C5066064:microsoft
cryptoapi:CryptAcquireCertificatePrivateKey:Invalid Signature.
Wed Mar 03 15:39:30 2010 Exiting

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


