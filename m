From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 6 Feb 2012 08:54:04 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B90129318119C@...1436...>
References: <1328442685-8550-1-git-send-email-dejong@...1435...>
	<1328442685-8550-2-git-send-email-dejong@...1435...>
	<20120205155727.GA9813@...1296...>
	<4F2EA949.4050400@...384...> <4F2F7F54.8060605@...1147...>
In-Reply-To: <4F2F7F54.8060605@...1147...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2] Removed support for
	calling	gc_malloc with a NULL gc_arena struct
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> -----Original Message-----
> From: Jan Just Keijser [mailto:janjust@...1147...]
>=20
> I agree with Gert:
> I spent most of my train journey yesterday figuring out what the next
> assert failure/segfault was , caused by this buffer.c change;
> env_set_create is one, log_history_add was also giving me problems, etc
> etc.
> With the 2.2.2 version of gc_malloc my Elliptic Curve patch works like
> a charm (in the git version of OpenVPN).
>=20
> The idea behind this change is good, but it needs a LOT of testing
> before we can proceed.
>=20

I agree. Gc_malloc is very low in the stack, and there are a lot of potenti=
al places that this could go wrong. Hunting them down is going to be a chal=
lenge. I'll see what I can do in the next few evenings. If I see it spirall=
ing out of control I'll let you know.

Adriaan

