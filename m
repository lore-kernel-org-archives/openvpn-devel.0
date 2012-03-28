MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
	<20120323141815.GC1359@...1296...>
	<CAEsd45Rzo14YeaYAWnMi65i__z3TuvqwQwzjTSdMRy8JMkWHMQ@...278...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Wed, 28 Mar 2012 15:57:22 +0200
Message-ID: <CAP+U6tJhzN+cJbSTqtHSwSAZoPm_7OnyOp=VYAUT99NvfdfRyg@...278...>
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Jonathan,

2012/3/28 Jonathan K. Bullard <jkbullard@...277...>:
> There is one part of=C2=A0check_cmd_access()=C2=A0which I took from code =
in
> run_up_down() and I am not sure about -- the three lines:
> =C2=A0 gc_arena gc;
> and
> =C2=A0 gc =3D gc_new ();
> and
> =C2=A0 gc_free (&gc);
>
> Are they needed? I put them in because I assume that they set up and tear
> down a global garbage-collection area where allocations are made, and that
> that area is used by argv_new() and whatever eventually allocates the argv
> structure's components when they are created by argv_printf() and/or
> parse_line().

gc_arena instances are used by explicitly passing a pointer to it. So,
unless one of the functions takes an instance of gc_arena as a
parameter, you don't need to prepare one. As many functions in OpenVPN
take one, there's some dead code scattered about that needlessly
creates and frees gc arenas (probably because uses have come and gone
over time). So you can drop gc because it's not used.

The argv family of functions apparently has its own memory management
and therefore argv_new() should be paired with an argv_reset().
Otherwise the memory allocated by argv_printf() is leaked.

Cheers
Fabian

