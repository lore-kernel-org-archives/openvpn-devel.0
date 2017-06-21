Message-ID: <103f1dec82c50941570c7103355b8457.squirrel@...2257...>
In-Reply-To: <20170621151835.GU97029@...1296...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
Date: Wed, 21 Jun 2017 17:25:32 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Hi,
>
> On Wed, Jun 21, 2017 at 04:18:41PM +0200, Simon Matter wrote:
>> An additional source of confusion seems that the tarball of the .gz and
>> .xz files don't match. Maybe this could easily be fixed in the build
>> process.
>
> .gz is built with "make distcheck", .xz right after from the same
> tree with "make dist-xz".
>
> What differs?

The check sum of both extracted tarballs, not really their content.

I suggest to create .xz from .gz instead of building another tarball. That
way the extracted tarballs from .gz and .xz share the same checksum ->
less confusion in case something goes wrong - as it did with 2.4.2 and
now.

Thanks,
Simon


