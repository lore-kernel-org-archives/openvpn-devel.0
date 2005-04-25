From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Newbie interested in Open VPN development
In-Reply-To: <20050423041950.38779.qmail@...377...>
Message-ID: <Pine.LNX.4.58.0504250208360.14285@...41...>
References: <20050423041950.38779.qmail@...377...>
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
Date: Mon Apr 25 01:35:18 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: kunal@...378...
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 22 Apr 2005, Kunal Punjabi wrote:

> Allow me to introduce myself. I am a graduate student
> from Georgia Tech and am interested in contributing to
> the Open VPN community, by developing code in C, C++
> or Java (those are the languages I am familiar with).
> C and C++ are my languages of choice.
> I have never contributed to open source before and
> want to get started. I am interested in ( but know
> little about) security. 
> If someone is willing to mentor me or guide me...and
> assign me a small project to get started on, I would
> be happy to put in some effort during my free time.
> Thanks and look forward to hearing from you folks!
> -Kunal

We don't really do formal mentoring here -- the process is more like try
to figure out as much as you can by yourself from reading the docs, list
archives, source code, etc., then post questions on the list if you get
stuck.

Most people contribute code because they have a strong desire to see a
particular feature implemented, as opposed to just having a general 
interest in the project.

Contributing code to the core is difficult, because you need to have a
more global understanding of how the code works, so you don't break
anything.  You also need to be well-versed in the art of portable
programming -- OpenVPN runs on a large number of platforms.

A simpler way of contributing would be to write a plugin or 
management interface client (such as a GUI).

James

