From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Re: Compilation Problem of =?utf-8?b?b3BlbnZwbi0yLjBfYmV0YTEx?=
In-Reply-To: <loom.20041014T220521-64@...171...>
Message-ID: <Pine.LNX.4.61.0410142221040.18018@...210...>
References: <loom.20041014T173717-97@...171...>
 <Pine.LNX.4.58.0410141115340.5469@...269...> <loom.20041014T220521-64@...171...>
MIME-Version: 1.0
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
Date: Thu Oct 14 13:28:17 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: zeeshaan <xeshaan@...293...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 14 Oct 2004, zeeshaan wrote:

> thanx Mathew actually i was doing wrong that i was not running ms/mw.bat first
>
> but now i am having problem with openssl as
>
> as it says
>
>
> f:/djgpp/bin/make.exe: unrecognized option `--win32'
>
> wats up now i think its something wrong with make now.

Well, djgpp isn't msys/mingw :-)

Try to remove djgpp from your system path, or just make sure msys and 
mingw is listed BEFORE djgpp.

-- 
_________________________________________________________
Mathias Sundman              (^)   ASCII Ribbon Campaign
NILINGS AB                    X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28      / \   NO Word docs in e-mail

