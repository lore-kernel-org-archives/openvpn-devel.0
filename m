MIME-Version: 1.0
References: <Yx5JdRcEXh2tTqPE@...1296...>
 <20220912091057.752-1-lstipakov@...277...>
 <YyHfQIvhNIItXw7h@...2685...>
In-Reply-To: <YyHfQIvhNIItXw7h@...2685...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Sep 2022 17:41:16 +0300
Message-ID: <CAGyAFMUXWrOoWE+3PmY5GWVT3X0BMFLkomU9pWvw0K09foEp-A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use DCO on Windows by default
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

> One general question about the patch: Whenever we have
> defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
> in the DCO code, couldn't we just remove it completely?
> Since this is bascially "every time" anyway, isn't it?

Well, almost. There is also Mac and some other platforms which do not have DCO.

We could likely get rid of those defines if we add disable_dco into
platform-specific tuntap_options
structures. Would it be better to have disable_dco member, assuming
platform doesn't support dco?

-- 
-Lev

