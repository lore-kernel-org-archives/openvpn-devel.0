References: <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
 <20180402114436.13662-1-steffan@...1856...>
 <CAKuzo_gOrByNN1AQ89hwR8ugc5coR58YnqdwqamKWEkGPdEQtg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <67564450-1ed5-ae9f-cc18-2ce65bfac6e8@...1856...>
Date: Sat, 6 Oct 2018 14:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gOrByNN1AQ89hwR8ugc5coR58YnqdwqamKWEkGPdEQtg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Improve management-external-key/cert
 error handling
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

On 03-04-18 04:53, Selva Nair wrote:
> But I can't believe I missed this in the last round. This else clause
> will now get executed not only if options->cert_file is false, but
> also if its true and the call to tls_ctx_use_external_private_key()
> succeeds! That would be wrong and is not what we want.

Thanks for catching this before it went into master!

For archiving purposes: this patch is no longer needed because it has
been superseded by the refactoring in "Do not load certificate from
tls_ctx_use_external_private_key()" (Message-Id:
<1536916459-25900-1-git-send-email-steffan.karger@...1435...>).

I'll register it like so in patchwork too.

-Steffan

