Message-ID: <36894307888518e6c9fa20594668882d.squirrel@...2257...>
In-Reply-To: <20170621154928.GX97029@...1296...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
	<103f1dec82c50941570c7103355b8457.squirrel@...2257...>
	<20170621154928.GX97029@...1296...>
Date: Wed, 21 Jun 2017 22:17:51 +0200
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
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Hi,
>
> On Wed, Jun 21, 2017 at 05:25:32PM +0200, Simon Matter wrote:
>> > .gz is built with "make distcheck", .xz right after from the same
>> > tree with "make dist-xz".
>> >
>> > What differs?
>>
>> The check sum of both extracted tarballs, not really their content.
>
> Ah.  Yeah, that's one of the drawbacks of building two independent
> tarballs - timestamps in the tar header (IIRC), so the end result always
> differs in a few bytes.
>
>> I suggest to create .xz from .gz instead of building another tarball.
>> That
>> way the extracted tarballs from .gz and .xz share the same checksum ->
>> less confusion in case something goes wrong - as it did with 2.4.2 and
>> now.
>
> David, you're listening?  Should be an easy-enough change from what
> we have now... ("gunzip <...tar.gz | xz >...tar.xz" or however you
> do xz balls) :-)

One more idea to make things go even smoother: In the release announcement
mails, you could also add the check sums for each release. That way
whatever Cloadflare delivers, one can check the sums which were received
trough a different channel.

Regards,
Simon


