References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-3-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d84a5dc0-bdc3-e72c-a8b5-3c69a3b4821f@...2080...>
Date: Tue, 8 Nov 2016 11:40:21 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-3-git-send-email-heiko.hund@...1489...>
Subject: Re: [Openvpn-devel] [PATCH 2/7] Remove unused and unecessary argv
 interfaces
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/10/16 18:42, Heiko Hund wrote:
> Signed-off-by: Heiko Hund <heiko.hund@...1489...> --- 
> src/openvpn/argv.c            | 53
> +++++++++++++++++++------------------------ src/openvpn/argv.h
> |  6 ----- src/openvpn/console_systemd.c |  3 +-- 
> src/openvpn/route.c           | 12 ++++------ src/openvpn/tun.c
> | 42 +++++++++++----------------------- 5 files changed, 41
> insertions(+), 75 deletions(-)
> 

ACK.  Looks good, cleans up not needed complexity.  Passes all tests,
valgrind doesn't report any memory leaks.

As for patch 1/7 ...  I will wait with applying this patch to the git
tree until all the other patches in this series have been reviewed and
ACKed.


- -- 
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIauUAAoJEIbPlEyWcf3yDWoQAKHRd/4hiM1Bdi4/ilvltZnW
ZcUdUsfxB3SUDniyfb6NXSXPkeDNaaqRSGcQNhBZ6MEC1WkRgBYcWL7fy/NEsPlT
WyUqTOjWknb9ka+ka1QT3wrhiE/naP4cI3oGxLpfxdRuHOXOwSQAKv3k/vqWWoyh
IayIUrFLMPirffogaZTc9Py5/v+s8EonPN+B3rJDC7BrQyRNimnX7s7LldtjLTo6
LhF2zTFBJowtYJryCgaQaaBIUcM8iDe0jZbH4iTqv4XmYtkjgMEWdKxIYyE0XiEk
gh4GkmplXaY9YPQJ5nFbKGZKNNyQ9yAESjZ9SkzUiV/U277u7SDdBiRrNS+g4nR3
nsGNwhyxdxnv8ryxaxJcHuXqOmFPr0c+6ZxEwKAEZVUh/q007YqEA8kul3sb5npC
BNNGXh03f2SzzMzQ0w9HA/GRFbSlsfMLsR3acVBxXXbrwg/+DttgUac7zFXv3PWm
tz4VMjAoi9chc8rY3fTvM4mwJzixeuzBbchLdSh6x8UCVApXlDUrX/DN8mx4DZis
EQesuL3bR8Saijn1XXLWcCE1+NDpxih9GBGziEicv84GM1KVRWBXi+7HleUDdgKp
B9LA5YzBS2OnjoyPRONrTCkFddaN4iYtNJLUKPSTPefd1q+0uKGyksR2Jft9zP6A
b5jdzmfuhbsnqBUEBpY9
=Tlfw
-----END PGP SIGNATURE-----

