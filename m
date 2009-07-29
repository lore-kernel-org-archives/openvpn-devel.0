MIME-Version: 1.0
Sender: sebastien.raveau@...277...
In-Reply-To: <9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
References: <4A5EFE61.3020100@...41...>
	<9e0cf0bf0907280218p25c081f7v203b4780309cb6b9@...278...>
	<4A6EFCFF.2090400@...1114...>
	<9e0cf0bf0907280650i3dabf036gc9e2f8c745823e15@...278...>
	<4A6F05B0.4020602@...1114...>
	<9e0cf0bf0907280720y45b629d5sd7fe3d2525811280@...278...>
	<3453b4110907281129x509c2bb1rbbfe4a817765e503@...278...>
	<4A6F634E.7020202@...1114...>
	<3453b4110907281422u4284faen6cd632e62f11cdf7@...278...>
	<9e0cf0bf0907282147n3dcdb7f6ue91065cc2d606f72@...278...>
Date: Wed, 29 Jul 2009 09:54:27 +0200
Message-ID: <3453b4110907290054h2850af18mbc688e677abf97b7@...278...>
From: Sebastien Raveau <sebastien.raveau@...1231...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Jul 29, 2009 at 6:47 AM, Alon Bar-Lev<alon.barlev@...277...> wrote:
> Well,
> I do not understand you guys.
>
> If you think SELinux is so great, why do you need chroot?
> It is like you put some money in safe, and then put the safe into
> another safe, it never ends... Why only two safe, let's put another
> safe...
> I know that this is the approach many of security advisors use, but I
> never could have found the logic.
> If you want to keep your money safe use a single safe and select the
> strongest one.

SELinux+chroot is indeed redundant, but as they do not conflict, why
not use them both?
To re-use your safe example: in your bank your belongings could be
protected by a smart safe, security guards and/or policemen... However
redundant that might be, I feel more comfortable knowing that more
means are used to protect my belongings :-)

> The daemon validates what SELinux or any other security
> product cannot validate: Network configuration changes. All done
> within a valid and separate context.

Indeed, indeed :-)

> As I wrote earlier, most of OpenVPN configurations need to execute
> iproute also during session. For example, if you like to connect two
> sites, your super SELinux secured solution will work only at one site.

Maybe so... I did not pretend SELinux was the ultimate solution to
every problem, and I straightforwardly recognize not knowing all
OpenVPN use cases. My will is only to offer more possibilities so that
everybody can find a combination that suits their needs: not everybody
uses the "user" or "chroot" option, probably even less people will use
the "setcon" option and who knows, maybe somebody will submit support
for doing the same with alternatives to SELinux (such as GRSecurity
and RSBAC).

> No need to discuss this further. I get your point.

Ok :-)

-- 
Sebastien Raveau

