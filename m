Message-ID: <53585356.8020602@...515...>
Date: Wed, 23 Apr 2014 17:57:10 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <53572C4E.7010701@...1901...>	<20140423081058.GJ16637@...1296...>	<53579C5D.5000902@...1435...>	<5357DDFC.2010401@...1901...>	<53581D43.6060501@...1856...>
	<53584B0C.8020209@...1901...>
In-Reply-To: <53584B0C.8020209@...1901...>
Subject: Re: [Openvpn-devel] Progress on Version negotiation
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
To: Timothe Litt <litt@...1901...>, Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 23/04/2014 17:21, Timothe Litt wrote:
> On 23-Apr-14 16:06, Steffan Karger wrote:
>> I generated a matching pair of traces of the failure (client and server)
>> & posted a summary.
>>
>> Let me know if you would like the full traces.
> Sent off-list.
>>
>> I've been trying to reproduce the error. I grabbed my spare pi from the
>> desk drawer and built 2.3.3 from sources like you describe in #385. I
>> fired up a Windows 8.1 VM, and installed OpenVPN 2.3.3-I002 (x64). This
>> setup however happily connects with TLSv1.2. It's hard to get a hold on
>> this one...
> My windows client is XP, 32-bit.  It's a physical machine (old notebook).
>
> Although the problem first surfaced on 2.3.3, I'm now running off
> git-master (of a few days back).  How I did that is in #385 too.
>
> For those on the list:
>
> With a hint from Steffan,
>
> I have established that the client certificate is not being sent.  I
> believe this is a client issue.
>
> It appears that including the cert/key in the conf file, rather than
> from the crypto API makes 1.2 work.
>
> We suspect there's some issue due to 1.2's larger hashes/message size.
> Not clear whether the cryptoapi interface is the cause or a victim.
>
> As I can't build the windows client (it's really annoying that it
> requires commercial tools), further debug will need help from folks who
> can.
>
> As always, let me know if I can do anything more to help.

I don't see that cryptoapi.c has been updated to work with TLS 1.2. 
Note the comment in rsa_priv_enc that says "For now, we only support 
NID_md5_sha1".  But TLS 1.2 appears to require the support of additional 
hash algorithms.

See section 4.7. "Cryptographic Attributes" in TLS 1.2 RFC.

Note that the signature algorithm is now specified along with the signature:

       struct {
          SignatureAndHashAlgorithm algorithm;
          opaque signature<0..2^16-1>;
       } DigitallySigned;

So it would appear that any client-side private key offloading (such as 
Crypto API, PKCS#11, OS-level KeyChains, etc. would need to be aware of 
this feature so as to take into account the hash algorithm.

James

