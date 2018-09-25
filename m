References: <20180925124819.4005-1-arne@...1227...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <cc77d438-2cc7-28a5-c1bf-f1afb46c303e@...1435...>
Date: Tue, 25 Sep 2018 17:54:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180925124819.4005-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add message explaining early TLS client
 hello failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 25-09-18 14:48, Arne Schwabe wrote:
> +                 "If your client is 2.3.6 or older  consider adding tls-version 1.1"
> +                 "to the the configuration to use TLS 1.1+ instead of TLS 1.0 only");

Don't you mean "adding tls-version-min 1.0 to the configuration to use
TLS 1.0+ instead of TLS 1.0 only." ?

Note both the -min postfix, and the use of 1.0 instead of 1.1.  I'd
expect that people that have such old clients around might even have
pre-2.3.2 clients, which only support TLS 1.0.  Those would not work
when setting tls-version-min 1.1 at the other end.

-Steffan

