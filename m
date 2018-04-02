MIME-Version: 1.0
In-Reply-To: <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
References: <CAKuzo_gvG3_Xz0qdHEyVOaEAB2CfSA3GNj7jYwHBkEb-kTMPLA@...278...>
 <20180308200848.5908-1-steffan@...1856...>
 <CAKuzo_hYvB2JjxZ3S8W4dB1+AOJqQW3VZJ2FgRXQJrDArkcFAQ@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 2 Apr 2018 13:50:26 +0200
Message-ID: <CAA1AbxLDvujop2b_bXsdQ4G2UGQmsy_NgkNGopHG7fGER+TowA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Improve management-external-key/cert
 error handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 9 March 2018 at 04:38, Selva Nair <selva.nair@...277...> wrote:
> I wanted to give this a quick test, but it doesn't apply.
>
> It seems you have patch 116 (Antonio's "inline-tag changed to bool"
> patch) in your local repo.

Oops, you're right - this was based on top of my local working branch,
which indeed includes Antonio's inline-tag cleanup patch. Just sent a
version based on current public master.

> By the way, the M_FATAL after management_query_cert() looks like a
> regression. One problem with these FATAL exits is that it makes it
> hard for the GUI to gracefully handle when user presses cancel on some
> dialogs. Anyway that's beyond this patch... So just saying..

Not really a regression, right?  Previously, management_query_cert()
would return NULL, which would cause
tls_ctx_use_external_private_key() to ASSERT out, because
tls_ctx_load_cert_file_and_copy() would not be able to return a valid
"cert" pointer.

But you're definitely right that the error handling over the
management interface could benefit greatly from some rework. (Beyond
this patch, indeed.)

-Steffan

