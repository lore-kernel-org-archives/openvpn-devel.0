From: Stefan Monnier <monnier@...1282...>
Message-ID: <jwvvd6o8ngt.fsf-monnier+inbox@...1269...>
References: <4C7EEF40.1050100@...1299...>
	<jwvmxs0a8vh.fsf-monnier+inbox@...1269...>
	<20100902083856.GG10703@...1296...>
Date: Thu, 02 Sep 2010 12:17:52 +0200
In-Reply-To: <20100902083856.GG10703@...1296...> (Gert Doering's message
	of "Thu, 2 Sep 2010 10:38:57 +0200")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn and dll hijacking?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

>> > Having apps that can't be tricked into downloading random DLLs from
>> > strange websites would certainly be a good thing ;-)
>> Upgrade to a sane system, like GNU/Linux and all your apps will be fixed
>> in one fell swoop,
> "if they were built with a sane rpath".

AFAIK, that's usually the case under most GNU/Linux distributions.

> Which is the whole point of the advisory: if you build applications wrongly,
> they will become vulnerable.

Yes, but those risks with rpath and friends have been known for a very
long time under unixy systems and have been taken fairly seriously, so
it's rather rare to find a vulnerable package in my experience (e.g.
I have never seen current-directory in the rpath).


        Stefan

