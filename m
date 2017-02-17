MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170217164131.GU93896@...1296...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 17 Feb 2017 18:37:04 +0100
Message-ID: <CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hello,

On Fri, Feb 17, 2017 at 5:41 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Feb 17, 2017 at 05:35:04PM +0100, Emmanuel Deloget wrote:
>> I understand that I'm the new guy in town, but can you allow me to
>> make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
>> require at least version 1.0.2?
>
> I'm not going to make a call on any of these versions, I just want
> to point out that we do need to (and *want* to) support older release
> of distributions that do not ship "most recent" OpenSSL versions yet.
>
> So we're somewhat caught in the middle between arch linux with 1.1.0
> and something like RHEL that ships seriously old OpenSSL (with patches).

My feeling is that RHEL6 and RHEL 7 are shipping v1.0.1 at least (both
updated the packages to 1.0.1e in March 2016). RHEL5 is still shipping
v0.9.8 (but then the installation of openvpn on RHEL 5 and Centos 5 is
fully manual as it seems there is no official packages for these
distrubutions). Of course, I might be wrong.

> This said, we need to regularily re-evaluate what the oldest distribution
> is that a given OpenVPN branch should support, and then we can drop support
> for older OpenSSL versions...

I guess the answer to the riddle is: "how long will the 2.4 branch
live?". v2.3 shipped in May 2013. If we assume that v2.4 will be the
stable branch for two more years (I cannot find any roadmap, so this
is pure speculation) then it might make sense for 2.5 to at least
remove support for OpenSSL v0.9.8 (it would have been EoL'd for 3
years by then). I must admit that the fact that I can build OpenVPN
against a security-focused library that haven't seen any evolution/bug
fix/security fix in one year makes me pretty shaky :)

>
> gert
>

BR,

-- Emmanuel Deloget

