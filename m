From: Simon Perreault <nomis80@...401...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <Pine.LNX.4.58.0506212216440.10675@...41...> <20050622084405.GA16345@...33...>
In-Reply-To: <20050622084405.GA16345@...33...>
MIME-Version: 1.0
Message-Id: <200506220838.36929.nomis80@...401...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jun 22 05:39:38 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wednesday 22 June 2005 04:44, Matthias Andree wrote:
> This could be run and determined automatically by the autoconf/automake
> couple, automake supports conditional compilation (i. e. depending on
> autoconf findings, link another module into a program, or something like
> that).

Yes, that would be nice. However, I personally don't have enough time to do 
this cleanly. The edit-the-makefile-if-you-have-a-broken-PAM solution 
satisfies me.

