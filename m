MIME-Version: 1.0
In-Reply-To: <4FB3BA1D.8060608@...1114...>
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
	<CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
	<4FB39166.9050906@...1114...>
	<CAOazyz2puY6DiXcDKiDy2QaUmHqEtSaTsdgZS6dj=D2RT73mzw@...278...>
	<4FB39E94.1070202@...1114...>
	<CAOazyz3SFQ9Wm070nvvhfn4E0bnpbwsfGc48rnhSMRLwpP_Y9A@...278...>
	<4FB3BA1D.8060608@...1114...>
Date: Wed, 16 May 2012 17:39:13 +0300
Message-ID: <CAOazyz0Y9iH+cvDuU3KzYwqcZKN7ZX+MpyDDCqpKdifzDey1kg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] eurephia plugin
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
To: David Sommerseth <openvpn.list@...1114...>, =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Wed, May 16, 2012 at 5:30 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>> But now that you describe you can do this using the plugin API,
>> why not modify the plugin to perform this and just remove this?
>
> I don't know if I'm the only user of this information or not. =C2=A0If I'm
> not, then we will break things for others as well. =C2=A0That I don't lik=
e,
> especially when the current implementation covers both plug-ins and
> scripts.

Well, this is exactly my point in rejecting these kind of merges into
the code, examples: Android case, Windows privilege separation case.
A great example!

There are no temporary merges, only maintenance costs and code complexity.
This why features should be maintained outside of tree until properly
merged with proper design.
This process it is not unique to this project.

I am for announcing the removal have the time for all plugins authors
which may use this feature to modify their code. There is enough time
to do so, we are talking about ~5 months.

I am not sure that anyone knows this one even exists as was unique to
David's need. So most probably only the eurephia should be modified.

Samuli, I think it is simple enough... in the 2.3_alpha2 announcement,
announce that the tls_digest_* environment is obsolete and until 2.3
release all plugins authors must modify their plugins to use the V3
interface to extract this information (if needed).

Alon.

