MIME-Version: 1.0
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-7-arne@...1227...>
In-Reply-To: <20200930131317.1299-7-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 21 Jan 2021 15:26:59 +0200
Message-ID: <CAGyAFMUyD8PgoAbsgeU3TmzqerDtShmf7LuziGRBgOfe0ToOJQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 05/11] Change parameter of
 send_auth_pending_messages from context to tls_multi
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> +/**
> + * Reschedule tls_multi_process.
> + * NOTE: in multi-client mode, usually the below two statements are

I realize that this comment is copied from existing code, but
"below two statements" is bit misleading here in the context of
function definition. Maybe just "this function" ?

Stared at the code, compiled with MSVC.

Acked-by: Lev Stipakov <lstipakov@...277...>

-- 
-Lev

