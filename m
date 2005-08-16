From: James Yonan <jim@...41...>
In-Reply-To: <1e6368e805081614142c7aa5f3@...278...>
Message-ID: <Pine.LNX.4.58.0508161525390.10152@...41...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...>
 <1e6368e805081614142c7aa5f3@...278...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 2.0.1 released -- note security fixes
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
Date: Tue Aug 16 14:30:26 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Leonard Isham <leonard.isham@...277...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

On Tue, 16 Aug 2005, Leonard Isham wrote:

> On 8/16/05, James Yonan <jim@...41...> wrote:
> > This release fixes a number of bugs in OpenVPN 2.0, including several bugs
> > in the server which might be used to mount a DoS attack.
> > 
> > Download:
> > 
> > http://openvpn.net/download.html
> > 
> > Change Log since 2.0:
> > 
> > 2005.08.16 -- Version 2.0.1
> > 
> 
> What is the recommended order of upgrade?
> 
> Server then clients or is this, what gets upgraded frst, a non-issue?

The DoS security fixes only affect the server, so it's less important to 
upgrade the clients.

James

