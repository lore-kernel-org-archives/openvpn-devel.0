Message-ID: <1e6368e80411081542783ff900@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] OpenVPN GUI not working with ms cert store
In-Reply-To: <Pine.LNX.4.61.0411082310460.8879@...210...>
Mime-Version: 1.0
References: <Pine.LNX.4.61.0411082202130.8879@...210...>
	 <Pine.LNX.4.61.0411082310460.8879@...210...>
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
Date: Mon Nov  8 15:48:26 2004
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 8 Nov 2004 23:19:19 +0100 (CET), Mathias Sundman
<mathias@...209...> wrote:
> On Mon, 8 Nov 2004, Mathias Sundman wrote:
[SNIP]
> Why do one always find the problem yourself the minute after posting to a
> list?!
> 
> The problem was in the way I called CreateProcess(). I used the
> dwFlags = STARTF_USESHOWWINDOW and wShowWindow = SW_HIDE in the
> start_info struct.
> 
> This was no-no! It seemed to suppress also windows dialogs!
> 
> If I instead used CREATE_NO_WINDOW as dwCreationFlags in the call to
> CreateProcess(), then the openvpn console window was still hidden, but
> Windows still shows the certficate store dialogs correctly.
> 
> Thanks to the list for just existing ;-)
> 
> There will soon be a new release available of OpenVPN GUI with the fix
> included...
> 
> /Mathias
[SNIP]

I'd guess different mindset.  Sort of like verbally explaining it to
some one and then it hits you.

-- 
Leonard Isham, CISSP
Ostendo non ostento.

