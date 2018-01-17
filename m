MIME-Version: 1.0
In-Reply-To: <CAKh=nwEfmTeh12nJzOycun60KMtgNN5B7SShrHvNV=xt2xBPwA@...278...>
References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
 <20180117131046.32402-1-logout@...260...>
 <20180117131046.32402-2-logout@...260...>
 <CAKh=nwEfmTeh12nJzOycun60KMtgNN5B7SShrHvNV=xt2xBPwA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Jan 2018 10:44:25 -0500
Message-ID: <CAKuzo_gEwUmRYh_trV4xJ0-sFvMsSr_BrB4LmrC=61NqEqe8=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/2] OpenSSL: remove EVP_PKEY_id()
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
To: Emmanuel Deloget <logout@...260...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Wed, Jan 17, 2018 at 8:14 AM, Emmanuel Deloget <logout@...260...> wrote:
> Of course, this one is not strictly needed. If you want to keep the function
> around, feel free to ignore the patch.
>
> Given the relative simplicity of the change, one can also consider that if
> the function is needed again we could simply revert this patch.

That's fine with me. My pending patches do not call this (at the expense
of double EVP_PKEY_get0_RSA() calls first to dispatch and then to do the
work) and I'm fine with it at the moment.

Selva

