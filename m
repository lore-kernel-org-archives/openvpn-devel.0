References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
	<5ffac4ab73daf53a27b5df238e7548e8.squirrel@...2257...>
	<20170621151835.GU97029@...1296...>
	<103f1dec82c50941570c7103355b8457.squirrel@...2257...>
	<20170621154928.GX97029@...1296...>
	<41fdab48-8ce0-0734-9829-a17206a9fbcc@...2080...>
	<20170621160218.GY97029@...1296...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <0f897439-58ec-7d23-bba9-1758893de92c@...68...>
Date: Wed, 21 Jun 2017 18:50:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170621160218.GY97029@...1296...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am 21.06.2017 um 18:02 schrieb Gert Doering:
> Hi,
>
> On Wed, Jun 21, 2017 at 05:58:18PM +0200, David Sommerseth wrote:
>> Hmmm ... not a bad idea.  But do we really need tar.gz at all these
>> days?  Why not just make autotools generate tar.xz by default and be
>> done with it?
> "distcheck" tends to just do .tar.gz - can you make it still do the check,
> but produce .tar.gz?

yes, in Makefile.am:
AUTOMAKE_OPTIONS=3D ...(whatever)... no-dist-gzip



