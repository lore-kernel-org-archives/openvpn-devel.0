MIME-Version: 1.0
References: <20211006090709.200-1-lstipakov@...277...>
 <CAFHpkQEfuk3+C5FL4st5GXxU0RNiYGH=dnDuVgyGUXdonRFepg@...278...>
 <CAGyAFMUWgLyW5PsoNT+ezQtA4x7W2vG4NUFSmbRR9FHDGH36HA@...278...>
 <YV3cZ1kNpMCJSA/r@...1296...>
In-Reply-To: <YV3cZ1kNpMCJSA/r@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Oct 2021 13:26:20 +0300
Message-ID: <CAGyAFMXM4mEw6KxgwjEogNFyDRU9xqoxsvbWbyz5mNRKdK8=9w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix loading PKCS12 files on Windows
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
Cc: ???????? ?????????????? <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> > Those are merged into the "master" branch, but not into "released". We
> > could probably include those into the next 2.5 release? Otherwise
> > they'll be part of 2.6.
>
> "You tell me".

The probable performance impact should be a less issue for master,
which in most cases will use dco on Windows.

For 2.5, let's conduct performance tests first. Balancing security
with performance tradeoffs is a difficult task.

-- 
-Lev

