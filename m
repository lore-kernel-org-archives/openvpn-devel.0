From: "James Yonan" <jim@...41...>
Message-ID: <twig.1071824797.70236@...41...>
In-Reply-To: <1071800799.7113.11.camel@...145...>
References: <20031219015511.7941.qmail@...146...>, <20031219015511.7941.qmail@...146...>
Subject: [Openvpn-devel] Re: [Openvpn-users] how many connections?
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
Date: Fri Dec 19 01:08:02 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: AthlonRob <AthlonRob@...144...>, openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

AthlonRob <AthlonRob@...144...> said:

> On Thu, 2003-12-18 at 17:55, Malaba Bibilow wrote:
> 
> > Any idea for the planning of the below feature ?
> > (point-to-multipoint, see attachement below)
> 
> Mr. Yonan has written quite long (and very descriptive) emails on the
> subject to the list in the past... I'm pretty sure the list has archives
> somewhere... and the subject lines were probably fairly descriptive.

Yes, the point-to-multipoint and forking server features have been discussed
at length in the archives.

I'm leaning towards an ultra-scalable design that would allow a single OpenVPN
process to accomodate potentially thousands of tunnels, using a single UDP
port, a single tun/tap interface, and a handful of threads.

> > In OpenVPN 1.6 ?
> > 
> > Easy ? Hard ?
> > Any blocking issues ? (re-code of major section ?)
> 
> I would guess probably not in OpenVPN 1.6, but I could be wrong, I'm not
> James.  :-)
> 
> The sheer amount of code that would need to be written, maintaining
> cross-platform compatibility will make it a very difficult task to
> undertake.  If I were in James' shoes, I would consider continuing along
> the same path laid out between 1.3, 1.4, and 1.5 for 1.6 and maybe even
> 1.7, 1.8, and 1.9... but branch it, now, and begin working towards a 2.0
> release including this added functionality.  I don't think much existing
> code needs to be rewritten so much as additional code needs to be
> written to take care of this.

The point-to-multipoint code will be in 2.0 -- I've already forked off a CVS
branch for it.

In the meantime, the plan is to keep the 1.5 series fairly stable, with only
minimalistic changes and bug fixes going into the code at this point.

Keep in mind that 2.0 is a large project that I basically work on during my
spare time, and that supporting the project with donations or other kinds of
financial support will measurably accelerate the development schedule :)

James


