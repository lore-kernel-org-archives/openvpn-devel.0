References: <1509192147.3021.6.camel@...2316...>
 <20171029152418.GF958@...1296...>
 <1509293083.3116.22.camel@...2316...>
 <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e939db91-a2a2-5b8f-7f35-88a4868e0b9d@...1856...>
Date: Wed, 1 Nov 2017 19:18:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_guDg74RXr1OssXSXLQk=xFoCFwjDkvSgkEvtGcVQR_DQ@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 0/1] add engine keys keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 29-10-17 22:03, Selva wrote:
> I would like to see new features transparently supported on Windows
> as well without the need for too much extra code and associated
> maintenance burden. Our 'cryptoapicert' implementation is already in
> need of a major re-write to support TLS 1.2 and newer.

Fully agree.  Since cryptoapicert is windows-specific, I actually think
it would be better to add a 'CNG'[0] implementation to the windows
wrapper, and make that use management-external-key.  That would probably
improve UX a lot too, showing users a drop-down to select a key, etc.
We can then remove the whole deprecated cryptoapi implementation from
the openvpn core.

> From that point of view, instead of file-based wrapped keys, if a pkcs11
> compatible API can be used to access TPM (that's possible isn't it?) TPM
> could be more widely usable without the need of any additional support
> in openssl or openvpn.

Since this one is transparent, and works as long as the user loads the
right engine, I don't see any limitations to include this patch.

-Steffan

[0]
https://msdn.microsoft.com/en-us/library/windows/desktop/aa376210(v=vs.85).aspx

