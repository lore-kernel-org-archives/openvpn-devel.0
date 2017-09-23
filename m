Message-ID: <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
In-Reply-To: <20170922205944.GA70062@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
 <20170922205944.GA70062@...1296...>
Date: Sat, 23 Sep 2017 10:52:16 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] lz4: Move towards a newer LZ4 API
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
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

> Hi,
>
> On Thu, Sep 07, 2017 at 10:40:21PM +0200, Simon Matter wrote:
>> While we are at it, I found it useful to see the used LZ4 version at
>> runtime as it is done with LZO and other libraries.
>>
>> I've patched my rpms with the patch attached.
> [..]
>
>> diff -Naur openvpn-2.4.0.orig/src/openvpn/comp-lz4.h
>> openvpn-2.4.0/src/openvpn/comp-lz4.h
>> --- openvpn-2.4.0.orig/src/openvpn/comp-lz4.h	2016-12-26
>> 12:51:00.000000000 +0100
>> +++ openvpn-2.4.0/src/openvpn/comp-lz4.h	2017-01-17 09:11:12.000000000
>> +0100
>> @@ -28,6 +28,10 @@
>>
>>  #if defined(ENABLE_LZ4)
>>
>> +#if defined(HAVE_LZ4_H)
>> +#include "lz4.h"
>> +#endif
>> +
>>  #include "buffer.h"
>
> Feature-ACK (I think this is a useful idea, for the same reasons we have
> LZO and OpenSSL versions :-) ), but that will not work if we use
> compat-lz4.h, so "code NAK".

IIRC at the time of writing this, the embedded lz4 was too old and didn't
have the LZ4_versionString() function. So the code won't work with the
patch. If the embedded code has LZ4_versionString() now, it should be ok.

Regards,
Simon

>
> comp-lz4.c currently has
>
> #if defined(NEED_COMPAT_LZ4)
> #include "compat-lz4.h"
> #else
> #include "lz4.h"
> #endif
>
> which might just be moved to comp-lz4.h, and then things should work.
>
>
>>  extern const struct compress_alg lz4_alg;
>> diff -Naur openvpn-2.4.0.orig/src/openvpn/options.c
>> openvpn-2.4.0/src/openvpn/options.c
>> --- openvpn-2.4.0.orig/src/openvpn/options.c	2016-12-26
>> 12:51:00.000000000 +0100
>> +++ openvpn-2.4.0/src/openvpn/options.c	2017-01-17 09:11:12.000000000
>> +0100
>> @@ -4121,11 +4121,17 @@
>>  #else
>>  #define LZO_LIB_VER_STR "", ""
>>  #endif
>> +#ifdef ENABLE_LZ4
>> +#define LZ4_LIB_VER_STR ", LZ4 ", LZ4_versionString()
>> +#else
>> +#define LZ4_LIB_VER_STR "", ""
>> +#endif
>>
>> -    msg(flags, "library versions: %s%s%s", SSL_LIB_VER_STR,
>> LZO_LIB_VER_STR);
>> +    msg(flags, "library versions: %s%s%s%s%s", SSL_LIB_VER_STR,
>> LZO_LIB_VER_STR, LZ4_LIB_VER_STR);
>>
>>  #undef SSL_LIB_VER_STR
>>  #undef LZO_LIB_VER_STR
>> +#undef LZ4_LIB_VER_STR
>>  }
>
> That part looks good.
>
> gert
>
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~=
gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>



