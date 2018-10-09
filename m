References: <CABMULt+srvCfNqio3FTmh0MLahFDh0mjWCpPyxoJQnWw0Ee+6w@...278...>
 <20181009152342.GG962@...1296...>
 <CABMULtKW13+tS-o9bfaFw6ecO=CVMq9Q12oznH5iBQ6d=k8dRQ@...278...>
 <20181009184349.GJ962@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <ed5f345f-cfd9-fcfc-9546-aac5dd586529@...1856...>
Date: Tue, 9 Oct 2018 21:01:16 +0200
MIME-Version: 1.0
In-Reply-To: <20181009184349.GJ962@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN cipher issue?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 09-10-18 20:43, Gert Doering wrote:
> (copying in openvpn-devel, as this is something Steffan will want to
> see...)
> 
> On Tue, Oct 09, 2018 at 06:41:30PM +0300, Alex K wrote:
>> Adding some more lines (verbosity 3):
>>
>> Tue Oct  9 15:38:17 2018 UDP link remote: [AF_INET]<remote>:1195
>> Tue Oct  9 15:38:17 2018 TLS: Initial packet from [AF_INET]<remote>:1195,
>> sid=45b5d735 c7b01909
>> Tue Oct  9 15:38:18 2018 VERIFY OK: depth=1, C=GR, ST=Attiki, L=Location,
>> O=Company, OU=Server, CN=Server, name=Server, emailAddress=
>> support@...2463...
>> Tue Oct  9 15:38:18 2018 VERIFY OK: nsCertType=SERVER
>> Tue Oct  9 15:38:18 2018 VERIFY OK: depth=0, C=GR, ST=Attiki, L=Location,
>> O=Company, OU=Server, CN=Server, name=Server, emailAddress=
>> support@...2463...
>> Tue Oct  9 15:38:20 2018 Control Channel: TLSv1.2, cipher TLSv1/SSLv3
>> ECDHE-RSA-AES256-GCM-SHA384, 1024 bit RSA
>> Tue Oct  9 15:38:20 2018 [Server] Peer Connection Initiated with
>> [AF_INET]<remote>:1195
>> Tue Oct  9 15:38:21 2018 SENT CONTROL [Server]: 'PUSH_REQUEST' (status=1)
>> Tue Oct  9 15:38:22 2018 PUSH: Received control message:
>> 'PUSH_REPLY,route-gateway 169.250.0.1,topology subnet,ping 120,ping-restart
>> 600,ifconfig 169.250.0.2 255.255.0.0,peer-id 0,cipher AES-256-GCM'
> 
> So, the TLS handshake works just fine.  The server recognizes that this
> is a new client that claims to be capable of using the AES-GCM cipher
> modes (= faster, more secure, less overhead) and sends back "please use
> AES-256-GCM"
> 
> [..]
>> Tue Oct  9 15:38:22 2018 WARNING: this configuration may cache passwords in
>> memory -- use the auth-nocache option to prevent this
>> Tue Oct  9 15:38:22 2018 Initialization Sequence Completed
> 
> Everything seems to be just fine.
> 
>> Tue Oct  9 15:38:41 2018 cipher_ctx_update_ad: EVP_CipherUpdate() failed
>> Tue Oct  9 15:38:41 2018 Exiting due to fatal error
> 
> 19 seconds later, "something explodes".
> 
> Possibly this is when the first packet is sent by the client or when
> the first packet comes in for decryption - "man EVP_CipherUpdate" says
> that this is for encryption or decryption.
> 
> The code in question is here:
> 
> cipher_ctx_update_ad(EVP_CIPHER_CTX *ctx, const uint8_t *src, int src_len)
> {
> #ifdef HAVE_AEAD_CIPHER_MODES
>     int len;
>     if (!EVP_CipherUpdate(ctx, NULL, &len, src, src_len))
>     {
>         crypto_msg(M_FATAL, "%s: EVP_CipherUpdate() failed", __func__);
>     }
>     return 1;
> #else  /* ifdef HAVE_AEAD_CIPHER_MODES */
>     ASSERT(0);
> #endif
> 
> ... which basically assumes "this operation can never fail".  If it does,
> the client gives up, because it does not know what to do.
> 
> 
> There are two things to test here
> 
>  - since you built from source (if I understand you right), run
>    "make check" in the openvpn source tree - this will test all cipher
>    modes including AES-GCM, so it should also fail
> 
>  - run the client with "--ncp-disable" configured - this will make it
>    stop advertising NCP capability to the server, so the server will
>    not try to push AES-256-GCM to the client.  Effectively bumping crypto
>    handshake to 2.3.x level.

This very much sounds like an old OpenSSL bug for which we added a
workaround in this commit:
https://github.com/OpenVPN/openvpn/commit/13de0103e

This typically occurred with the OpenSSL version shipped with Ubuntu
12.04, which had a buggy AEAD interface.

Either upgrading your OpenSSL or your OpenVPN to a recent version should
be sufficient to make it work.

-Steffan

