MIME-Version: 1.0
In-Reply-To: <4FB38570.90902@...1114...>
References: <CAOazyz0V=cE7R=nTefCbP4Z1=+WoYnxhPfNuWasEZjf1EUSOHA@...278...>
	<4FB3810A.4050209@...1114...>
	<CAOazyz11iQ6wuNJ_tp=2U5gH5=jeLkLHL6EG_8+yrDjXtEbFUA@...278...>
	<4FB38570.90902@...1114...>
Date: Wed, 16 May 2012 13:55:11 +0300
Message-ID: <CAOazyz29iYJ2rDPBZzk0Otac543AcYFf_gbHgRgaFo+qcVLpTQ@...278...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Wed, May 16, 2012 at 1:46 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 16/05/12 12:37, Alon Bar-Lev wrote:
>> On Wed, May 16, 2012 at 1:27 PM, David Sommerseth
>> <openvpn.list@...1114...> wrote:
>>>
>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>>>
>>> On 16/05/12 09:17, Alon Bar-Lev wrote:
>>>> Hello David,
>>>>
>>>> I guess this is yours: --- * =C2=A0Additions for eurephia plugin
>>>> done by: * =C2=A0 =C2=A0 =C2=A0 =C2=A0 David Sommerseth
>>>> <dazo@...384...> Copyright (C) 2009 ---
>>>>
>>>> Looking at the code the eurephia plugin only do the following:
>>>> --- #ifdef ENABLE_PLUGIN_EUREPHIA /* export X509 cert SHA1
>>>> fingerprint */ { unsigned char *sha1_hash =3D
>>>> x509_get_sha1_hash(peer_cert, &gc);
>>>>
>>>> openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d",
>>>> cert_depth); setenv_str (es, envname, format_hex_ex(sha1_hash,
>>>> SHA_DIGEST_LENGTH, 0, 1, ":", &gc)); } #endif ---
>>>>
>>>> Can you please explain what this plugin is and why just remove
>>>> the conditional?
>>>
>>> You can find more info about the plug-in here:
>>> http://www.eurephia.net/
>>>
>>> Basically, it's a username/password authentication plug-in which
>>> also matches a user account up against a certificate too (plus
>>> some extra features too as well). =C2=A0The 'tls_digest_%d'
>>> environment variable is used to get better data when matching
>>> certificates information against the database.
>>>
>>> I've been thinking that this whole #ifdef could go away in v2.4.
>>> It was a requirement from James to make this optional which is
>>> the reason it is how it is. =C2=A0He wanted to be sure it can be
>>> disabled if there were stability concerns. =C2=A0As this has been
>>> enabled by default in 2.2 and will be in 2.3, I thought 2.4 would
>>> be a reasonable time to confirm the stability.
>>>
>>> The [eurephia] string can also be removed then from options.c
>>> too; and I'll make sure the eurephia docs states that v2.4
>>> contains the support even though not explicitly announced.
>>
>> Thanks. I don't see any reason why not to remove the #ifdef for
>> 2.3... it is default enabled anyway, so it is not like people
>> should explicit enable this and get lower stability.
>
> It was actually the other way around. =C2=A0If people had stability issue=
s,
> which might be related to environment tables growing too big (or
> somewhat related issues), this feature could be disabled to see if
> that helped it. =C2=A0Doing it like it is implemented made James happy, so
> I didn't argue about it.

hmmm... why not to digest only end certificate? this what you actually
need right?

>
>> Anyway, if the need of the digest is valid then it is not specific
>> to this plugin.
>
> AFAIK, eurephia is the only plug-in depending on this feature, and it
> this feature arrived first in v2.2. =C2=A0So it was kind of to have a
> clearer reference to what this feature is about. =C2=A0But I see that this
> information can be useful for other plug-ins/scripts as well.

The whole point of plugin is that no change in base... conditionals
should be based on functionality.

Thanks,
Alon

