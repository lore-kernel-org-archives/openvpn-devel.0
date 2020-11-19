References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <50c23608-1b71-1651-fa4e-af0d39aba7b3@...2525...>
Date: Thu, 19 Nov 2020 13:23:47 +0100
MIME-Version: 1.0
In-Reply-To: <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
Content-Type: multipart/alternative;
 boundary="------------6342CD693DED0E07931F81FC"
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------6342CD693DED0E07931F81FC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arne,

some time has passed and I was able to address most of your comments in 
my branch 
https://github.com/julek-wolfssl/wolfssl/tree/openvpn-2.5-missing-stuff

To summarize what has been done regarding your comments:

  * SHA1 was indeed being called SHA in wolfSSL. I changed this in favor
    of just using SHA1.
  * in configure.ac I used David Sommerseth's suggestion to use
    PKG_CHECK_MODULES to get the wolfSSL installation directory.
  * setting tls min and max is currently not working in the branch that
    I linked above but we have a big compatibility layer PR pending that
    appears to fix these issues. Once it is merged I'll revisit this
    issue and make sure it is solved.
  * show-tls is fixed but it also relies on the PR I mentioned earlier.
    After that is merged this should be solved.
  * tls-ciphersuites and tls-cipher appears to be working in general.
    Should wolfSSL reject the specified cipher if for example a TLS 1.3
    cipher is set using --tls-cipher?
  * unfortunately wolfSSL does not support ed448 certificates.
  * tls-groups now checks the validity of the passed in curves
  * since OpenVPN will make use TLS EKM, exporting keying material has
    been implemented in wolfSSL.
  * I haven't tested OpenVPN with the FIPS mode patch so that issue is
    still pending. Once I get a chance to test it I will also change
    wolfSSL to target 1.1.0+ API

Thanks for your patience!

Sincerely
Juliusz

On 17/09/2020 00:05, Arne Schwabe wrote:
> Am 16.09.20 um 11:45 schrieb Juliusz Sosinowicz:
>> Hi Arne,
>>
>> a quick update. A PR is now open in wolfSSL with fixes for OpenVPN master.
> This is the version that I could actually take a deeper look at, so here
> are my results. It generally works but there seems some loose ends:
>
>
> I am still seeing this warning:
>
>
> 2020-09-16 23:20:14 WARNING: 'auth' is used inconsistently, local='auth
> SHA', remote='auth SHA1'
>
> Are you internally calling SHA1 just SHA and are also returned that as
> name when querying for the name? And do the other SHA variant also just
> return SHA?
>
>
> This snippet in the configure.ac looks strange:
>
> 	if test -n "${WOLFSSL_DIR}"; then
> 		wolfssldir="${WOLFSSL_DIR}"
> 	else
> 		wolfssldir="/usr/local/include/wolfssl"
> 	fi
>
> I am not sure hardcoding a /usr/local path is something we want/allow.
> The people better at autoconf might have a better idea on this.
>
> 	have_crypto_aead_modes="yes"
> 	have_crypto="yes"
>
> While the have_crypto_aead removal is a rather new removal, the
> have_crypto removal happened over 4 years ago (31b0bebe). I think the
> configure.ac should be cleaned up a bit more.
>
>
> --tls-version-max 1.2 option is ignored.
>
> --tls-version-min 1.3 against a (OpenSSL) server with --tls-version-max
> 1.2 results in:
>
> 2020-09-16 23:45:26 OpenSSL: Please supply a buffer for error string
> 2020-09-16 23:45:26 OpenSSL: Please supply a buffer for error string
>
> (A quick fix with just trying to do a malloc of a buffer that leaks
> memory transformed this in the also useless message OpenSSL: unknown
> error number)
>
> openvpn --show-tls does not work at all
>
>
> Setting tls-ciphersuites results in (on the server side for the TLS 1.2
> max server):
>
> 2020-09-16 23:54:22 us=503265 79.229.32.216:57019 TLS error: The server
> has no TLS ciphersuites in common with the client. Your --tls-cipher
> setting might be too restrictive.
>
> I can also set TLS 1.3 cipher to tls-cipher. The design of TLS 1.3
> ciphersuites and 1.0-1.2 cipher suites using different command is an
> artificat of OpenSSL's behaviour but basically setting using
> tls-cipher/tls-ciphersuites in the way the were intended seems to break
> wolfSSL.
>
> Loading the ed448 cert I have resulted in:
>
> 2020-09-16 23:58:28 OpenSSL: Please supply a buffer for error string
>
> again.
>
>
> --tls-groups meinekurve does not give me an error. So this option is
> probably also ignored.
>
> I am not expecting you test all the zillion options that OpenVPN has but
> at least testing the TLS related option would be good. And what I am
> currently seeing is not really a good coverage/buggy.
>
> Even if some of the option might be a good option for support in
> WolfSSL, we need to document this and/or your API needs to throw
> reaonable errors.
>
>
> Same notes since I ran WolfSSL also on my own development that includes
> a few patches already sent to the mailing list but not merged:
>
>
> This definition in WolfSSL:
>
> wolfssl/openssl/ssl.h:#define SSL_export_keying_material(...) 0
>
>
> This just breaks TLS EKM as WolfSSL pretensd to be able to do keying
> material export but then cannot really do it. The patches to use TLS EKM
> are currently not in master but will be definitively added until 2.6.
>
> The macro have_export_keying_material="yes"  currently also missing in
> the wolfssl configure.ac section but if enabling it, it just breaks:
>
> =2020-09-16 23:31:17 TLS Error: Keying material export failed
> 202=0-09-16 23:31:17 TLS Error: generate_key_expansion failed
>
> The "allow to work in FIPS mode" patch also breaks for the OpenSSL 1.0.2
> code path:
>
>      EVP_MD_CTX_set_flags(&ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
>
>   error: use of undeclared identifier 'EVP_MD_CTX_FLAG_NON_FIPS_ALLOW'
>   warning: implicit declaration of function 'EVP_MD_CTX_set_flags' is
> invalid in C99
>
> I am surprised you are targeting OpenSSL < 1.1.0 API. We will probably
> drop OpenSSL 1.0.2 support from our code base as soon as we drop RHEL7
> support. The 1.1.0+ code path in that patch uses the
> EVP_PKEY_derive_*/EVP_PKEY_CTX_set_tls1_prf functions and those will be
> needed then.
>
> Arne
>

--------------6342CD693DED0E07931F81FC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Arne,</p>
    <p>some time has passed and I was able to address most of your
      comments in my branch
      <a class="moz-txt-link-freetext" href="https://github.com/julek-wolfssl/wolfssl/tree/openvpn-2.5-missing-stuff">https://github.com/julek-wolfssl/wolfssl/tree/openvpn-2.5-missing-stuff</a></p>
    <p>To summarize what has been done regarding your comments:</p>
    <ul>
      <li>SHA1 was indeed being called SHA in wolfSSL. I changed this in
        favor of just using SHA1.<br>
      </li>
      <li>in configure.ac I used David Sommerseth's suggestion to use
        PKG_CHECK_MODULES to get the wolfSSL installation directory.</li>
      <li>setting tls min and max is currently not working in the branch
        that I linked above but we have a big compatibility layer PR
        pending that appears to fix these issues. Once it is merged I'll
        revisit this issue and make sure it is solved.</li>
      <li>show-tls is fixed but it also relies on the PR I mentioned
        earlier. After that is merged this should be solved.</li>
      <li>tls-ciphersuites and tls-cipher appears to be working in
        general. Should wolfSSL reject the specified cipher if for
        example a TLS 1.3 cipher is set using --tls-cipher?</li>
      <li>unfortunately wolfSSL does not support ed448 certificates.</li>
      <li>tls-groups now checks the validity of the passed in curves</li>
      <li>since OpenVPN will make use TLS EKM, exporting keying material
        has been implemented in wolfSSL.</li>
      <li>I haven't tested OpenVPN with the FIPS mode patch so that
        issue is still pending. Once I get a chance to test it I will
        also change wolfSSL to target 1.1.0+ API</li>
    </ul>
    <p>Thanks for your patience!</p>
    <p>Sincerely<br>
      Juliusz<br>
    </p>
    <div class="moz-cite-prefix">On 17/09/2020 00:05, Arne Schwabe
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...">
      <pre class="moz-quote-pre" wrap="">Am 16.09.20 um 11:45 schrieb Juliusz Sosinowicz:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Arne,

a quick update. A PR is now open in wolfSSL with fixes for OpenVPN master.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
This is the version that I could actually take a deeper look at, so here
are my results. It generally works but there seems some loose ends:


I am still seeing this warning:


2020-09-16 23:20:14 WARNING: 'auth' is used inconsistently, local='auth
SHA', remote='auth SHA1'

Are you internally calling SHA1 just SHA and are also returned that as
name when querying for the name? And do the other SHA variant also just
return SHA?


This snippet in the configure.ac looks strange:

	if test -n "${WOLFSSL_DIR}"; then
		wolfssldir="${WOLFSSL_DIR}"
	else
		wolfssldir="/usr/local/include/wolfssl"
	fi

I am not sure hardcoding a /usr/local path is something we want/allow.
The people better at autoconf might have a better idea on this.

	have_crypto_aead_modes="yes"
	have_crypto="yes"

While the have_crypto_aead removal is a rather new removal, the
have_crypto removal happened over 4 years ago (31b0bebe). I think the
configure.ac should be cleaned up a bit more.


--tls-version-max 1.2 option is ignored.

--tls-version-min 1.3 against a (OpenSSL) server with --tls-version-max
1.2 results in:

2020-09-16 23:45:26 OpenSSL: Please supply a buffer for error string
2020-09-16 23:45:26 OpenSSL: Please supply a buffer for error string

(A quick fix with just trying to do a malloc of a buffer that leaks
memory transformed this in the also useless message OpenSSL: unknown
error number)

openvpn --show-tls does not work at all


Setting tls-ciphersuites results in (on the server side for the TLS 1.2
max server):

2020-09-16 23:54:22 us=503265 79.229.32.216:57019 TLS error: The server
has no TLS ciphersuites in common with the client. Your --tls-cipher
setting might be too restrictive.

I can also set TLS 1.3 cipher to tls-cipher. The design of TLS 1.3
ciphersuites and 1.0-1.2 cipher suites using different command is an
artificat of OpenSSL's behaviour but basically setting using
tls-cipher/tls-ciphersuites in the way the were intended seems to break
wolfSSL.

Loading the ed448 cert I have resulted in:

2020-09-16 23:58:28 OpenSSL: Please supply a buffer for error string

again.


--tls-groups meinekurve does not give me an error. So this option is
probably also ignored.

I am not expecting you test all the zillion options that OpenVPN has but
at least testing the TLS related option would be good. And what I am
currently seeing is not really a good coverage/buggy.

Even if some of the option might be a good option for support in
WolfSSL, we need to document this and/or your API needs to throw
reaonable errors.


Same notes since I ran WolfSSL also on my own development that includes
a few patches already sent to the mailing list but not merged:


This definition in WolfSSL:

wolfssl/openssl/ssl.h:#define SSL_export_keying_material(...) 0


This just breaks TLS EKM as WolfSSL pretensd to be able to do keying
material export but then cannot really do it. The patches to use TLS EKM
are currently not in master but will be definitively added until 2.6.

The macro have_export_keying_material="yes"  currently also missing in
the wolfssl configure.ac section but if enabling it, it just breaks:

=2020-09-16 23:31:17 TLS Error: Keying material export failed
202=0-09-16 23:31:17 TLS Error: generate_key_expansion failed

The "allow to work in FIPS mode" patch also breaks for the OpenSSL 1.0.2
code path:

    EVP_MD_CTX_set_flags(&amp;ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);

 error: use of undeclared identifier 'EVP_MD_CTX_FLAG_NON_FIPS_ALLOW'
 warning: implicit declaration of function 'EVP_MD_CTX_set_flags' is
invalid in C99

I am surprised you are targeting OpenSSL &lt; 1.1.0 API. We will probably
drop OpenSSL 1.0.2 support from our code base as soon as we drop RHEL7
support. The 1.1.0+ code path in that patch uses the
EVP_PKEY_derive_*/EVP_PKEY_CTX_set_tls1_prf functions and those will be
needed then.

Arne

</pre>
    </blockquote>
  </body>
</html>

--------------6342CD693DED0E07931F81FC--

