MIME-Version: 1.0
In-Reply-To: <4FB20713.30804@...1458...>
References: <20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
	<20120513121906.GL1359@...1296...>
	<CAOazyz3WetA0vHpm965krjKm=OiFovT1JRi39T9kOY2sf7-khA@...278...>
	<20120513130750.GN1359@...1296...>
	<CAOazyz1hA7EGOhoOtOgNgAcH91Y4crs1TrTzgDbC6_MbgA8reQ@...278...>
	<20120513181038.GP1359@...1296...>
	<CAOazyz2NzD76kqdM4v+fPK4uuvCd6E-oh79EpGv5p1K=ZZTucw@...278...>
	<4FB20713.30804@...1458...>
Date: Tue, 15 May 2012 10:38:09 +0300
Message-ID: <CAOazyz3bvKTxYoZJzQ_V1CH+oKehQcG83M-_GDEeARD1Qiov+A@...278...>
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
To: Seth Mos <seth.mos@...1458...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, May 15, 2012 at 10:34 AM, Seth Mos <seth.mos@...1458...> wrote:
> Op 13-5-2012 20:23, Alon Bar-Lev schreef:
>> On Sun, May 13, 2012 at 9:10 PM, Gert Doering<gert@...1296...> =C2=A0wro=
te:
>
>> Come on! most of installations are plain public key without any of
>> these plugins.
>> There is no need for these if you configure your server.
>> I simply don't understand your attitude... sorry, I simply don't.
>
> Please note that we include OpenVPN in the pfSense product, and we
> pretty much provide access to a huge number of options in the UI.
>
> There are quite a lot of installs out there that use OpenVPN with
> certificates and Radius authentication.
>
> Regardless, we need to ship with pretty much all options enabled. We are
> not going to ship 15 images to get all the options. And letting users
> install other "packages" to get the features seems silly.
>
> We're not a OpenWRT where the small memory footprint is limiting what
> you can do.
>
> So just because most users don't use the other features that makes it a
> valid argument? Ehm. not sure on that.
>
> Cheers,
>
> Seth

So basically what you want is to use adding the auth radius into the
core package.

Alon.

