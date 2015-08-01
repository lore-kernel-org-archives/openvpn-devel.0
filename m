Message-ID: <55BCC254.4050808@...1227...>
Date: Sat, 01 Aug 2015 14:57:56 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1435748590-7820-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1435748590-7820-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix overflow check in openvpn_decrypt()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: steffan.karger@...1435..., openvpn-devel@lists.sourceforge.net

Am 01.07.15 um 13:03 schrieb steffan.karger@...1435...:
> From: Steffan Karger <steffan.karger@...1435...>
> 
> Sebastian Krahmer from the SuSE security team reported that the buffer
> overflow check in openvpn_decrypt() was too strict according to the
> cipher update function contract:
> 
> "The amount of data written depends on the block alignment of the
> encrypted data: as a result the amount of data written may be anything
> from zero bytes to (inl + cipher_block_size - 1) so outl should contain
> sufficient room."
> 
> This stems from the way CBC mode works, which caches input and 'flushes'
> it block-wise to the output buffer.  We do allocate enough space for this
> extra block in the output buffer for CBC mode, but not for CFB/OFB modes.
> 
> This patch:
>  * updates the overflow check to also verify that the extra block required
>    according to the function contract is available.
>  * uses buf_inc_len() to double-check for overflows during en/decryption.
>  * also reserves the extra block for non-CBC cipher modes.
> 
> In practice, I could not find a way in which this would fail. The plaintext
> is never longer than the ciphertext, and the implementations of CBC/OFB/CBC
> for AES and BF in both OpenSSL and PolarSSL/mbed TLS do not use the buffer
> beyond the plaintext length when decrypting.  However, some funky OpenSSL
> engine I did not check *might* use the buffer space required by the
> function contract.  So we should still make sure we have enough room
> anyway.
> 

ACK from me.

Arne


