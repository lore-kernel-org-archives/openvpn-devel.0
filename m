MIME-Version: 1.0
References: <Yv9fczYCUEM3i6V4@...1296...>
 <20220819193005.210-1-lstipakov@...277...>
 <YwEGlqATPpa7ATpb@...1296...>
In-Reply-To: <YwEGlqATPpa7ATpb@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 21 Aug 2022 09:16:59 +0300
Message-ID: <CAGyAFMUX9suAfWWsDanhk=ZYbQW2tY8hmpbj3sbsCJf0_qU+tQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v102 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Selva <selva.nair@...277...>, Simon Rozman <simon@...2293...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

(adding Selva, Simon and Samuli just in case :)

If anyone could / want to test it - MSI installers could be found here:

  https://github.com/lstipakov/openvpn-build/actions/runs/2894560760

To enable dco driver, add

  --windows-driver ovpn-dco-win

I myself tested it on my Windows 10 laptop (udp / tcp), will check
today later on the Windows Server 2022 VM and my son's Windows 11 PC.

But since I contributed to the client code and the driver, it would be
great to get confirmation from someone else :)

I'll also try to get some QA resources from the corp side on Monday.

la 20. elok. 2022 klo 19.06 Gert Doering (gert@...1296...) kirjoitti:
>
> Hi,
>
> On Fri, Aug 19, 2022 at 10:30:05PM +0300, Lev Stipakov wrote:
> > From: Antonio Quartulli <a@...2181...>
> >
> > With this change it is possible to use ovpn-dco-win when running OpenVPN
> > in client or P2P mode.
> >
> > Signed-off-by: Arne Schwabe <arne@...1227...>
> > Signed-off-by: Lev Stipakov <lev@...515...>
> > Signed-off-by: Antonio Quartulli <a@...2181...>
>
> I am fine with the code changes, and I have tested this on FreeBSD
> and Linux with/without DCO (full set takes like ~2 hours now) - so
> what worked before still works.
>
>
> I am *not* going to merge this "just based on this", because I want to
> be sure it actually works on Win10/Win111 with dco... can I get a
> tester?  Richard refuses to do Win10, so, no DCO for him... :-(
>
> (But I have confirmation that the resulting installers still work fine
> for tun/tap and wintun on Win7, so that's at least reassuring :-) ).
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...



-- 
-Lev

