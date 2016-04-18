References: <5710B96E.6070603@...515...>
	<CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <57148594.6010803@...1435...>
Date: Mon, 18 Apr 2016 08:58:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
Subject: Re: [Openvpn-devel] New EV-signed tap-windows6 driver ready for
 testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Selva,

On 18-04-16 00:03, Selva Nair wrote:
> - Windows 7 (64 bit): success, but see below
> 
> Installs without error and works fine. 
> However, the driver details says that its _not_ digitally signed, but
> the driver properties window shows "Digitally signed by OpenVPN
> Technologies Inc."
> Installing KB3123479 (update to support SHA2 signatures) makes no
> difference.
> 
> [...]
> 
> - Windows vista (32 bit): installs after ignoring security warning,
> works fine
> 
> Installation: Pops up a warning that says no valid signature, publisher
> not verified etc. On choosing to install anyway, completes without error.
> Tap adapter works fine
> 
> I thought driver signature is not enforced on 32 bit vista, but this is
> the only platform (among those I tried) that complained loudly at
> installation time.
> 
> Note: none of the above systems are up-to-date with windows updates.

Windows 7 only received support for kernel driver signatures with SHA256
digests about a year ago (the first attempt by MS, a year before that,
failed and MS had to revoke their patch).  Userland support for SHA256
digests has been available for much longer.  I guess that the situation
for Vista is about the same.  So the fact that the system are not fully
patched could explain the failures.

-Steffan

