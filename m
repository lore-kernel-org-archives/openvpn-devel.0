Message-ID: <54EAE4AF.8010009@...1227...>
Date: Mon, 23 Feb 2015 09:28:31 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <20150124170446.GA504@...2009...> <54E10A03.3000400@...1227...>
	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...>
In-Reply-To: <20150223080402.GA5068@...2009...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Vasily Kulikov <segoon@...2008...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 23.02.15 um 09:04 schrieb Vasily Kulikov:
>     management-external-cert 'macosx-keychain:SUBJECT:c=US'
>
> With the approach in patch v3 a user has to start openvpn with the
> config file, start keychain-mcd, and pass identity template as an
> argument to keychain-mcd.
>
> What do you think of the change?
I like the idea. You could  make the macos-keychain in the string optional.

Arne

