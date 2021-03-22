MIME-Version: 1.0
References: <20210321144627.1621-1-simon@...2293...>
 <20210321165045.GY976@...1296...>
 <487884f67f874d438ca181de91399c52@...2293...>
 <20210322085411.GG976@...1296...>
In-Reply-To: <20210322085411.GG976@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 22 Mar 2021 11:51:46 +0200
Message-ID: <CAGyAFMWGbuN-0x=V9DpGzL4w+fWhz6d=4ce0x5+cg3DN8HOzKw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] MSVC: Disable LZ4
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
To: Gert Doering <gert@...1296...>
Cc: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

For 2.6, I think we should drop openvpn-build for Windows (VS)
building and switch to vcpkg for dependencies (openssl, lz4 etc) and
cmake as a project file (also supported by VS).

-- 
-Lev

