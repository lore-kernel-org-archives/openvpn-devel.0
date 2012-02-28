MIME-Version: 1.0
In-Reply-To: <4F4C6C14.9030303@...1550...>
References: <4F4BE238.502@...1550...>
	<CAOazyz19-bfVtb+o2tt86S5txE3iofBhAz+JR5hw7-qHmfoVeQ@...278...>
	<4F4C6C14.9030303@...1550...>
Date: Tue, 28 Feb 2012 10:51:58 +0200
Message-ID: <CAOazyz3hsYzEX6irEvgr894XoUgyoG9bUvYeN7XmYO=EQCBKzA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 02/02] Remove calls to OpenSSL when
 building with --disable-ssl
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
To: Igor Novgorodov <igor@...1550...>
Cc: openvpn-devel@lists.sourceforge.net

Hmmm....
I really can't tell... maybe can be removed until someone reports an issue.=
..
I just remember that there were cases it was needed and cases it wasn't.
It will not hurt to call these in any case.

On Tue, Feb 28, 2012 at 7:54 AM, Igor Novgorodov <igor@...1550...> wrote:
> Then maybe we should move these calls to crypto_openssl.c into
> crypto_init_lib() function to make crypto.c library-independent?
> And why OpenSSL_add_all_algorithms() and stuff is called only when USE_SSL
> is not defined?
>
> And if these calls are for 0.9.8, maybe add a check for OpenSSL version?
>
>
> On 28.02.2012 0:10, Alon Bar-Lev wrote:
>>
>> These are needed for 0.9.8 as far as I remember.
>> On Mon, Feb 27, 2012 at 10:06 PM, Igor Novgorodov<igor@...1550...> =C2=
=A0wrote:
>>>
>>> The attached patch removes deprecated(?) calls to OpenSSL functions from
>>> crypro.c,
>>> which are called when USE_SSL is not defined.
>>>
>>> I'm not so deep into OpenVPN, so maybe these functions are needed, but i
>>> thought that all crypto-lib
>>> dependent functions should be moved to the corresponding crypto_LIB.c
>>> files.
>>>
>>> If they are needed, we should #ifdef them, so that PolarSSL-based build
>>> won't break on it.
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Try before you buy =3D See our experts in action!
>>> The most comprehensive online learning library for Microsoft developers
>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
>>> Metro Style Apps, more. Free future releases when you subscribe now!
>>> http://p.sf.net/sfu/learndevnow-dev2
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>
>

