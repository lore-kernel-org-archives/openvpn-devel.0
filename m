Message-ID: <534B8A45.8040006@...1147...>
Date: Mon, 14 Apr 2014 09:12:05 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <20140413152613.GT16637@...1296...>
In-Reply-To: <20140413152613.GT16637@...1296...>
Subject: Re: [Openvpn-devel] RFD: ssl library version numbers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

Gert Doering wrote:
> Hi,
>
> OpenVPN does not currently report the version of the SSL library it is
> using - which I'm not sure whether it's by design or just because nobody
> ever added it.  Anyway, right now I think we need it, to help future
> cases.
>
> There are a few questions that go along with that, which I want to discuss
> here :-)
>
> - shall we report compile-time versions as well, or only run-time version?
>
>   Like:
>
> 	OpenSSL compile version='OpenSSL 1.0.1f 6 Jan 2014'
> 		library version='OpenSSL 1.0.1g 7 Apr 2014'
>
>   (this is on one of my test systems where I discovered an old OpenSSL
>   installation, and upgraded *after* I built the OpenVPN binary)
>
>   While I always like seeing numbers, I think the compile-time version is
>   not actually that useful - if the ABI is not compatible, it will break,
>   and if it is, the library version is what is relevant.
>
>   
+1 for this; I'd go for runtime versions only , although it might be an 
interesting debug flag to get the compile time version as well - it 
might aid in debugging cases where the ABI is supposed to be compatible, 
but isn't .
> - how do I get the library version for PolarSSL?
>
>   
void version_get_string_full( char *string )


> - shall we report the library version to the server, e.g. in the form of
>
>    IV_SSL=OpenSSL 1.0.1f
>    IV_SSL=PolarSSL 1.2.8
>
>   as a sysadmin on the server side, I'd welcome this ("show me what my
>   users are running").  From a security geek side, I'm not sure whether
>   there is potential for abuse, so "please give me your input"
>
>   

> - if we report it, do we want to report it always (as IV_VER) or only
>   if --push-peer-info is set?
>
>   
we're reporting the openvpn version info anyway, so adding the SSL lib 
version would not change much; if it is only returned when 
--push-peer-info is set then there shouldn't be any privacy/security 
concerns, esp if the info is given *AFTER* the initial connection is 
made (i.e. after the first certificate handshake).


while we're at it : if we're printing out (not reporting) the version 
number of the SSL lib, why not also print out the version numbers of the 
other libs
- zlib
- pkcs11-helper
- snappy?

this is what 'curl' does and it has saved me debugging time in some 
strange cases.

JM2CW,

JJK




