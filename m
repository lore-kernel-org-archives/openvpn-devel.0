Message-ID: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
In-Reply-To: <20170404064534.GC93896@...1296...>
References: <ee5a8207241568cedcccc4f7f2ea5bc8.squirrel@...2257...>
	<b6bac00d6d7260eea944814b0c995806.squirrel@...2257...>
	<53a21cf3f4e04fcf5d6b9798e04be3ce.squirrel@...2257...>
	<20170404064534.GC93896@...1296...>
Date: Tue, 4 Apr 2017 09:30:08 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Add per session pseudo-random component
 to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Tue, Apr 04, 2017 at 08:29:49AM +0200, Simon Matter wrote:
>> Interesting to see that there is zero interest in this patch here.
>
> This is a misinterpretation.
>

Hi Gert,

Thanks for the explanation, I'll be patient then :)

If it's preferred for the patch to keep it even simpler and compatible the
current configs, it could be broken down to something like this in init.c:

#define RENEG_RND_PCT 25

to.renegotiate_seconds =3D max_int((int)options->renegotiate_seconds -
(get_random() % (options->renegotiate_seconds / (100 / RENEG_RND_PCT))),
1);


With the default config this should result in reneg times in the range of
2700 ... 3600 seconds.

Thanks,
Simon


