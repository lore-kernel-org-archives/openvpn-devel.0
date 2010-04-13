MIME-Version: 1.0
In-Reply-To: <4BC48199.4060600@...1114...>
References: <1269951178-30419-1-git-send-email-dazo@...384...>
	<4BBE3205.1040303@...1114...>
	<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>
	<4BC47655.10101@...1114...>
	<t2o9e0cf0bf1004130659l5c4a8dc2o6eab22db336078be@...278...>
	<4BC48199.4060600@...1114...>
Date: Tue, 13 Apr 2010 17:41:31 +0300
Message-ID: <l2z9e0cf0bf1004130741redfc5e60i63cc6dc764506ac5@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
	./configure information to --version
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

As you wish.

On Tue, Apr 13, 2010 at 5:37 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 13/04/10 15:59, Alon Bar-Lev wrote:
>>> Alon, with all respect, it is great getting feedbacks to submitted
>>> > patches, even REVERT suggestions. =C2=A0Could you perhaps share some =
thoughts
>>> > about how to solve it, instead of just rejecting it?
>> I did.
>> I sent you an example of how we solve it in OpenSC and Suspend.
>>
>> http://www.opensc-project.org/opensc/browser/trunk/configure.ac#L613
>>
>> autoconf log was NEVER intended to be used as programming interface,
>> and is far than being stable.
>
> I feel you oversee something. =C2=A0The configure_h.awk script uses confi=
g.h,
> which is included in most of the C files already.
>
> The config.log is *only* used for getting the command line of how
> ./configure was called, via configure_log.awk. =C2=A0To my knowledge, this
> information is not available anywhere else. =C2=A0If I have overseen this
> somewhere, then please enlighten me.
>
> The config.log is also not used as a programming interface. =C2=A0One sta=
tic,
> configure time related line is *extracted* and compiled into the binary.
> =C2=A0This is extraction of useful debug information for situation where =
the
> openvpn-testing code is distributed in binary.
>
> If this configure line is not found, an empty string will be the result,
> so no openvpn features are harmed. =C2=A0With the clean-up patches, it wi=
ll
> now also compile without any issues. =C2=A0And to my knowledge config.log
> does not change after Make begins to compile the source code.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkvEgZQACgkQDC186MBRfrrMXACgjWOB2de9DITHjyoXQJYFEhuk
> DpoAmwcqCjnPttfxzw9VoNOBv0nknM5g
> =3DCiw2
> -----END PGP SIGNATURE-----
>

