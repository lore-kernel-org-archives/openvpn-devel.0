MIME-Version: 1.0
In-Reply-To: <20120513121906.GL1359@...1296...>
References: <CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
Date: Sun, 13 May 2012 15:24:59 +0300
Message-ID: <CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Sun, May 13, 2012 at 3:19 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sun, May 13, 2012 at 02:26:05PM +0300, Alon Bar-Lev wrote:
>> OK... now you are talking... so you say that like apache we need to
>> integrate the plugins to main build system, this was the other
>> alternative.
>
> This would make more sense to me. =C2=A0Either have them as optional
> "configure" components, or just build and install all of them all
> the time.
>
> If we ignore the examples, we really only have "auth-pam" and "down-root"
> in the main distribution today, and those are useful in many cases - so
> I'd go for "always build and install them".

And always have pam dependency for this example?
These plugins should be optional I don't see any value in enforcing
them and their dependencies.

Alon.

