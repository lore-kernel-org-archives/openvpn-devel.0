References: <20180316164059.9120-1-xiaoningning@...109...>
 <CAKuzo_h9=+BeTmg5t=H9nUQbqqi8r4DFd7oPrSBOSArQepj3_w@...278...>
 <1783935013.3421880.1521493221569@...2084...>
 <CAKuzo_jpgG8V-Y5ikxW1uwGNvoQoTJeCca=Wosg9UC_dPGJj6Q@...278...>
 <2645433.792870.1522082204205@...2084...>
 <7694eb51-64cb-44ba-4333-280b2cab76f8@...1856...>
 <CAKuzo_iDp1FLkFxFgy7jfND3viVgf2nraNv=8Oa3uwbAVX63-Q@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <39f4bd5e-50a1-ebe4-7591-9c135dc44c81@...1856...>
Date: Wed, 2 May 2018 21:37:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iDp1FLkFxFgy7jfND3viVgf2nraNv=8Oa3uwbAVX63-Q@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Increase TLS Control Channel Buffer Size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,
Hi,

On 02-05-18 20:40, Selva Nair wrote:
> On Wed, May 2, 2018 at 2:30 PM, Steffan Karger <steffan@...1856...> wrote:
>> On 26-03-18 18:36, Ning Wei via Openvpn-devel wrote:
>>> Both of key_method_2_write and key_method_2_read take
>>> TLS_Channel_Bug_Size as buffer size.  The current size, 2048 is not
>>> enough to read/write a long password response.  I have notice the
>>> management interface has a much smaller than 2048 buffer size to
>>> read/write.  Currently, if the management interface is not used,
>>> increasing tls channel buffer size will serve the need.
>>>
>>> As token provider, the size of token can be bigger or smaller.
>>> Sometime, it has more than 1600 as a token.  To accommodate that, a
>>> bigger buffer size will be needed.
>>
>> I don't think this is achieving what you want.  The username/password
>> size on the OpenVPN protocol are fixed at 128 bytes max, and can not be
>> changes without introducing a new protocol version or interoperability
>> problems.  See the USER_PASS_LEN variable used in key_method_2_read.
> 
> USER_PASS_LEN is 4096 (not 128) for builds with ENABLE_PKCS11 and that was
> the assumption behind this patch.
> 
> I'm not endorsing this patch but we do need changes to management interface and
> option parsing to allow long user/pass strings to support newer
> challenge-response
> protocols. Those changes are not hard but this patch falls short as I
> had pointed
> out earlier.

You're of course absolutely right.  USER_PASS_LEN is not actually an
interop issue here, the user/pass strings are not fixed length.  Too
quick with the answer, apologies.

But I think changing TLS_CHANNEL_BUF_SIZE will result in tricky
behaviour; when reading from the TLS channel, current implementations
read upto 2048 bytes, and pass that to key_method_2_read() as if it was
the whole message.  If the user/pass exceeds the old max, that will
result in truncated username/passwords, and finally password
verification errors.  It's not fatal, but sounds like really annoying to
debug...

-Steffan

