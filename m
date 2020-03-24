MIME-Version: 1.0
References: <20200322123521.17710-1-chipitsine@...277...>
In-Reply-To: <20200322123521.17710-1-chipitsine@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Mar 2020 10:48:36 +0200
Message-ID: <CAGyAFMVjM1-zzeWgrKOSm9UrKh6Tn4DO143H2jvj5Z9NbhSWow@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add arm64, s390x builds.
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Tested with my openvpn github fork - all jobs passed and overall
travis dashboard looks nice thanks to added "name" field.

It would be even nicer to have "arch" as part of name, because now it looks like

     gcc | openssl-1.1.1d
     gcc | openssl-1.1.1d

But this is already step forward and improvements could be done in a
separate patch.

Acked-by: Lev Stipakov <lstipakov@...277...>

