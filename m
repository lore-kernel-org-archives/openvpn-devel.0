From: Charles Duffy <cduffy@...294...>
Message-ID: <e0ts4v$ljt$1@...165...>
References: <20060403102922.GB2617@...30...> <4431F7C4.4030804@...41...>
Mime-Version: 1.0
In-Reply-To: <4431F7C4.4030804@...41...>
Subject: [Openvpn-devel] Re: Possible security bug
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
Date: Tue Apr  4 06:32:25 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
> Alberto,
> 
> By default, the OpenVPN client doesn't accept pushed options from the 
> server unless "pull" or "client" is specified.  The idea is that once 
> you agree to accept configuration info from the server, you are trusting 
> (to a certain extent) in its integrity, so there are limits in how far 
> the client can be protected against a server which successfully 
> authenticates at the SSL/TLS level, but then turns out to be malicious.
> 
> But Hendrik has a point in that you might want that trust to be 
> finer-grained -- you might want to accept routes pushed from a server, 
> but not a setenv (which could potentially be abused).

Hmm. I actually like Hendrik's proposed solution -- allowing setenv by 
default, but only to a subset of the possible namespace (by prefixing 
variable names). Any reason you're leaning towards disabling setenv 
altogether unless explicitly allowed?


