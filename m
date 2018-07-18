MIME-Version: 1.0
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 18 Jul 2018 19:46:38 -0400
Message-ID: <CAEsd45Rd+5_NTeQ_E1C9wps89GWU6OfxQ5CdEFiN_HCO0=xaAQ@...278...>
Subject: [Openvpn-devel] Dynamic challenge/response questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

I'm trying to implement dynamic challenge/response in Tunnelblick and
have some questions. I've been using the management-interface
documentation [1] as my guide.

1. Is what the management interface sends something like (all on one line):

>PASSWORD:Verification Failed: 'Auth' ['CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN:']

and not just the challenge all by itself?


2. Is the final ":" in the above part of the prompt to be shown to the
user, or is it a delimiter showing the end of the prompt?


3. Is the response back to the management interface really like this:

Username: cr1 ("Y3Ix" base64 decoded)
Password: CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::8675309

I ask because the syntax for the username/password for a
NON-challenge/response response back to the management interface is

username "Auth" THE_USERNAME
password "Auth" THE_PASSWORD

which has "username" and "password" in lower-case and without the ":"s.


4. Can the Username and Password fields sent to the OpenVPN management
interface be quoted (and must double-quotes within the fields be
escaped), as with the NON-challenge/response response?


Thanks,

Jon Bullard

[1] https://openvpn.net/index.php/open-source/documentation/miscellaneous/79-management-interface.html

