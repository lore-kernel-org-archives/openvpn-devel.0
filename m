References: <1513246897-28171-1-git-send-email-steffan@...1856...>
 <20171214154408.GA69387@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <2cb2b3e7-368b-d363-3751-d8bde8b55cfe@...1856...>
Date: Thu, 14 Dec 2017 17:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <20171214154408.GA69387@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] ssl_openssl: fix compiler warning by
 removing getbio() wrapper
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 14-12-17 16:44, Gert Doering wrote:
> On Thu, Dec 14, 2017 at 11:21:37AM +0100, Steffan Karger wrote:
>> -    if (!ret)
>> -    {
>> -        crypto_msg(M_FATAL, "Error creating %s BIO", desc);
>> -    }
> 
> I'm not sure how likely these are going to fail, but the crypto_msg()
> had the benefit of actually telling us what the underlying library
> returned as error code...
> 
> If this won't ever happen except under very exceptional conditions, it
> won't matter much, though.

Fair point, but this is very unlikely to fail indeed.  We use standard
openssl-provided BIO_METHOD's, and do not do threading.  The one error I
could imagine is a malloc failure.

I still think it's fine to just go with the ASSERT().

-Steffan

