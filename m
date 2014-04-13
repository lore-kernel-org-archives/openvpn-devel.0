Message-ID: <534AC25C.9000302@...1227...>
Date: Sun, 13 Apr 2014 18:59:08 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1397366216-657-1-git-send-email-cernekee@...277...>
	<20140413104705.GL16637@...1296...>
	<CAJiQ=7DYg6PnTJ0piiUDKaT5wefVBxvPH3ZPHANQxOgWeDHjPg@...278...>
	<534AAAEC.7050105@...1227...>
	<CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
In-Reply-To: <CAJiQ=7COCWVzV1pq+ek8zimj65CdB0UM8S+1om1k8p_75yDjRA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] Support non-root operation using
 ocproxy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kevin Cernekee <cernekee@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 13.04.2014 18:31, Kevin Cernekee wrote:
> On Sun, Apr 13, 2014 at 8:19 AM, Arne Schwabe <arne@...1227...> wrote:
>> You could look at the TARGET_ANDROID. That uses the management interface and
>> fds over unix socket to achieve something similar.
> Do you think it would be feasible to enable TARGET_ANDROID by default
> in the Linux OpenVPN builds, and change the logic so that if the user
> passes e.g. "--android" it will accept commands over the management
> socket instead of using the standard CLI?
I am sure how invasive a patch that allows --android would be.

Arne

