MIME-Version: 1.0
In-Reply-To: <20180228231123.27782-1-steffan@...1856...>
References: <20180228231123.27782-1-steffan@...1856...>
From: Steffan Karger <steffan@...1856...>
Date: Thu, 1 Mar 2018 10:08:04 +0100
Message-ID: <CAA1Abx+Eu3v7TVuSu2TX9PqUnP8tk4U4r=Q9u6edmh-ucUS+FQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning that we do not officially
 support LibreSSL
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

[resending because the list rejected my mail from yesterday...]

On 1 March 2018 at 00:11, Steffan Karger <steffan@...1856...> wrote:
> +    msg(M_WARN, "WARNING: This OpenVPN was built against LibreSSL. "
> +        "This might work, but is *not* supported and can break at any time.")

Gah, this of course needs a ; at the end of the line - forgot to amend
the commit before git send-email...

-Steffan

