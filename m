Message-ID: <556238FD.5040202@...1856...>
Date: Sun, 24 May 2015 22:47:57 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <55619DC4.2020108@...1856...> <5562310A.1040108@...1147...>
In-Reply-To: <5562310A.1040108@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Clarify --capath option in manpage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Jan Just,

On 24-05-15 22:14, Jan Just Keijser wrote:
> On 24/05/15 11:45, Steffan Karger wrote:
>> Prevent confusion as described in trac #422 by better explaining the
>> behaviour of --capath, and providing pointers to relevant openssl man
>> pages.
>>
>> Attached are patches for the master and release/2.3 branches.  The
>> only difference is that in the master patch, a line referencing the
>> requirement for OpenSSL 0.9.7 is removed, since master already
>> requires OpenSSL >= 0.9.8.
>
> I intend to NACK this patch -  AFAIK it is *not* required to use .r0 CRL
> files with --capath.
> You can run your setup perfectly fine without them (last time I checked).
> However, *IF* one wants to use CRL files in combination with --capath
> then you must supply .r0 files .

Hmm, interesting.  I actually tested this in response to trac ticket 
#422 [0], where the users complains about --capath not working because 
of an error "VERIFY ERROR: depth=0, error=unable to get certificate 
CRL".  My test setup with --capath instead of --ca resulted in the same 
behaviour, until I provided a CRL.  Since --capath basically makes sense 
for multiple CAs, and it is not possible to provide multiple CRL files 
through --crl-verify, I decided pointing the users at the '<hash>.r<n>' 
files was the best way to go.

When using --capath, our code does (ssl_openssl.c:955 in master):

    X509_STORE_set_flags (store, X509_V_FLAG_CRL_CHECK |
        X509_V_FLAG_CRL_CHECK_ALL);

and the OpenSSL manpages seems to confirm that will result in the 
behaviour reported in trac #422, and in my tests:

    X509_V_FLAG_CRL_CHECK enables CRL checking for the certificate chain
    leaf certificate. An error occurs if a suitable CRL cannot be found.

    X509_V_FLAG_CRL_CHECK_ALL enables CRL checking for the entire
    certificate chain.

That said, I would not be surprised if there is some catch here that I 
missed.  So I'm very interested to hear it if that is the case.

-Steffan

[0] https://community.openvpn.net/openvpn/ticket/422

